# Import libraries
import json
import os
import re
import shutil
import zlib
from pathlib import Path

# Import modules
from errors import ToolError
from project import project_find_file, project_get_root, project_get_sandbox

# Constants
MACROS_FILE = "scripts/config_macros/config_macros.gml"
FOLDER_FILE = "scripts/file_get_folder/file_get_folder.gml"
PREFIX_PATTERN = re.compile(r'return\s+"(\w+)"\s*\+\s*_folder;')
OPTIONS_FILE = "options/windows/options_windows.yy"
EXECUTABLE_PATTERN = re.compile(r'"option_windows_executable_name"\s*:\s*"([^"]+?)(?:\.exe)?"')
FOLDERS = ("config", "saves")
FILE_EXTENSION = ".dat"
MAX_DECODED_BYTES = 1 << 20
INT64_MASK = (1 << 64) - 1
INT64_SIGN = 1 << 63


# Functions
def saves_add_arguments(parser):
	parser.add_argument(
		"--dir",
		help="Save folder of the game, the one that holds config and saves. Defaults to the folder under APPDATA.",
	)
	parser.add_argument(
		"--replay",
		action="store_true",
		help="Read the folders that a replay scenario writes and not the ones of a player.",
	)
	actions = parser.add_mutually_exclusive_group()
	actions.add_argument("--backup", action="store_true", help="Copy the folders to .sandbox, and refuse when a copy is already there.")
	actions.add_argument("--clear", action="store_true", help="Delete the .dat files, and refuse when there is no copy to restore.")
	actions.add_argument("--restore", action="store_true", help="Put the copy back, which also removes whatever was added since, and delete the copy.")


def saves_read_folders(root, args):
	# Return the names of the folders that hold the files
	if not args.replay:
		return FOLDERS
	match = PREFIX_PATTERN.search((root / FOLDER_FILE).read_text(encoding="utf-8"))
	if not match:
		raise ToolError(f"{FOLDER_FILE} no longer prefixes the folders of a replay, so --replay cannot find them. Update the pattern in saves.py.")
	return tuple(match.group(1) + folder for folder in FOLDERS)


def saves_read_macro(root, name):
	# Return the text a macro of config_macros holds
	code = (root / MACROS_FILE).read_text(encoding="utf-8")
	match = re.search(rf"^#macro\s+{name}\s+(\S+)\s*$", code, re.MULTILINE)
	if not match:
		raise ToolError(f"{MACROS_FILE} has no macro {name}, so the files cannot be read. Add it back or fix the name.")
	return match.group(1)


def saves_find_directory(args, root, folders):
	if args.dir:
		return Path(args.dir)

	base = os.environ.get("APPDATA")
	if not base:
		raise ToolError("APPDATA is not set, so the save folder is unknown. Pass it with --dir.")

	# The folder is named after the project, with underscores, or after the executable
	names = [project_find_file(root).stem.replace("-", "_")]
	options = root / OPTIONS_FILE
	if options.exists():
		match = EXECUTABLE_PATTERN.search(options.read_text(encoding="utf-8"))
		if match:
			names.append(match.group(1))
	for name in names:
		candidate = Path(base) / name
		if any((candidate / folder).is_dir() for folder in folders):
			return candidate
	raise ToolError(
		f"No save folder found under {base} named {' or '.join(names)}. Run the game once, or pass the folder with --dir."
	)


def saves_wrap(value):
	# Keep a number inside a signed 64 bit integer, as GameMaker does
	value &= INT64_MASK
	return value - (1 << 64) if value & INT64_SIGN else value


def saves_unscramble(data, key):
	# Undo the XOR that Sphinx applies to every byte
	state = saves_wrap(key)
	result = bytearray(data)
	for index in range(len(result)):
		state ^= saves_wrap(state << 13)
		state ^= state >> 17
		state ^= saves_wrap(state << 5)
		result[index] ^= state & 0xFF
	return bytes(result)


def saves_decompress(data):
	decompressor = zlib.decompressobj()
	try:
		text = decompressor.decompress(data, MAX_DECODED_BYTES)
	except zlib.error as error:
		raise ToolError(f"The bytes are not compressed data ({error}), so the file is damaged or the key is not CIPHER_KEY.")
	if decompressor.unconsumed_tail:
		raise ToolError(f"The data is larger than {MAX_DECODED_BYTES} bytes, which no save file of the game reaches.")
	return text


def saves_decode(data, key, is_encrypted):
	if is_encrypted:
		data = saves_decompress(saves_unscramble(data, key))
	try:
		return json.loads(data.decode("utf-8").rstrip("\0"))
	except ValueError as error:
		raise ToolError(f"The content is not JSON ({error}), so the file is damaged.")


def saves_get_backup(root, folders):
	# One copy for each set of folders, so a replay never mixes with a player
	return project_get_sandbox(root) / f"saves-backup-{folders[0]}"


def saves_backup(root, directory, folders):
	backup = saves_get_backup(root, folders)
	if backup.exists():
		raise ToolError(f"A copy already exists in {backup}, so it was not overwritten. Put it back with --restore, or delete that folder when you do not need it.")
	backup.mkdir()
	for folder in folders:
		if (directory / folder).is_dir():
			shutil.copytree(directory / folder, backup / folder)
	print(f"[INFO] Copied {', '.join(folders)} to {backup}")


def saves_clear(root, directory, folders):
	files = [file for folder in folders for file in (directory / folder).glob(f"*{FILE_EXTENSION}")]
	if files and not saves_get_backup(root, folders).exists():
		raise ToolError("There is no copy of these files, so nothing was deleted. Run it with --backup first.")
	for file in files:
		file.unlink()
	print(f"[INFO] Deleted {len(files)} {FILE_EXTENSION} files from {', '.join(folders)}")


def saves_restore(root, directory, folders):
	backup = saves_get_backup(root, folders)
	if not backup.exists():
		raise ToolError(f"There is no copy in {backup}, so nothing was restored. Make one with --backup.")
	for folder in folders:
		if (directory / folder).is_dir():
			shutil.rmtree(directory / folder)
		if (backup / folder).is_dir():
			shutil.copytree(backup / folder, directory / folder)
	shutil.rmtree(backup)
	print(f"[INFO] Restored {', '.join(folders)} from the copy and deleted the copy")


def saves_show(args):
	root = project_get_root()
	key = int(saves_read_macro(root, "CIPHER_KEY"))
	is_encrypted = saves_read_macro(root, "USE_ENCRYPTION") == "true"
	folders = saves_read_folders(root, args)
	directory = saves_find_directory(args, root, folders)
	print(f"[INFO] Save folder {directory}")

	# Change the files and stop
	for is_asked, action in ((args.backup, saves_backup), (args.clear, saves_clear), (args.restore, saves_restore)):
		if is_asked:
			action(root, directory, folders)
			return 0

	failures = 0
	found = 0
	for folder in folders:
		for file in sorted((directory / folder).glob(f"*{FILE_EXTENSION}")):
			found += 1
			name = f"{folder}/{file.name}"
			data = file.read_bytes()
			try:
				table = saves_decode(data, key, is_encrypted)
			except ToolError as error:
				failures += 1
				print(f"[ERROR] {name} ({len(data)} bytes) {error}")
				continue
			print(f"[INFO] {name} ({len(data)} bytes)")
			print(json.dumps(table, indent=2, sort_keys=True))

	if found == 0:
		print(f"[WARNING] No {FILE_EXTENSION} files in {', '.join(folders)} under {directory}")
	return 1 if failures else 0

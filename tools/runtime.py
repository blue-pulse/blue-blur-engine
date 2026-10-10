# Import libraries
import os
import platform
import re
from dataclasses import dataclass
from pathlib import Path

# Import modules
from errors import ToolError

# Constants
ENV_RUNTIME_DIR = "GM_RUNTIME_DIR"
ENV_USER_DIR = "GM_USER_DIR"
ENV_PREFABS_DIR = "GM_PREFABS_DIR"

VERIFIED_SYSTEM = "Windows"
INSTALL_DIR_PATTERN = "GameMakerStudio2*"
LICENCE_FILE_NAMES = ("licence.plist", "license.plist")
PREFABS_DIR_NAME = "Prefabs"

IGOR_RELATIVE_PATHS = {
	"Windows": ("bin/igor/windows/x64/Igor.exe", "bin/igor/windows/Igor.exe"),
	"Darwin": ("bin/igor/osx/arm64/Igor", "bin/igor/osx/x64/Igor", "bin/igor/osx/Igor"),
	"Linux": ("bin/igor/linux/x64/Igor", "bin/igor/linux/Igor"),
}


# Classes
@dataclass
class Runtime:
	version: str
	directory: Path
	igor: Path


# Functions
def runtime_add_arguments(parser):
	parser.add_argument(
		"--runtime-dir",
		help=f"Runtime folder named runtime-<version>. Overrides {ENV_RUNTIME_DIR}.",
	)
	parser.add_argument(
		"--user-dir",
		help=f"Folder that holds the licence file. Overrides {ENV_USER_DIR}.",
	)
	parser.add_argument(
		"--prefabs-dir",
		help=f"Prefabs folder of the installation. Overrides {ENV_PREFABS_DIR}.",
	)


def runtime_warn_if_unverified():
	system = platform.system()
	if system != VERIFIED_SYSTEM:
		print(
			f"[WARNING] These tools were only verified on {VERIFIED_SYSTEM} and this is {system}, so a path may be wrong."
		)


def runtime_get_override(argument, variable):
	value = argument or os.environ.get(variable)
	return Path(value).expanduser() if value else None


def runtime_get_version_key(version):
	return tuple(int(part) for part in re.findall(r"\d+", version))


def runtime_get_search_roots():
	system = platform.system()
	if system == "Windows":
		bases = [
			Path(os.environ.get("PROGRAMDATA", "C:/ProgramData")),
			Path(os.environ.get("APPDATA", Path.home() / "AppData/Roaming")),
		]
	elif system == "Darwin":
		bases = [Path("/Users/Shared"), Path.home() / "Library/Application Support"]
	else:
		bases = [Path.home() / ".local/share", Path("/var/opt"), Path("/opt")]
	roots = []
	for base in bases:
		roots.extend(sorted(base.glob(f"{INSTALL_DIR_PATTERN}/Cache/runtimes")))
	return roots


def runtime_find_igor(directory):
	for relative_path in IGOR_RELATIVE_PATHS.get(platform.system(), ()):
		candidate = directory / relative_path
		if candidate.is_file():
			return candidate
	return None


def runtime_list_installed():
	runtimes = []
	for root in runtime_get_search_roots():
		for directory in sorted(root.glob("runtime-*")):
			igor = runtime_find_igor(directory)
			if directory.is_dir() and igor:
				runtimes.append(
					Runtime(directory.name.removeprefix("runtime-"), directory, igor)
				)
	return runtimes


def runtime_find(args, ide_version):
	override = runtime_get_override(args.runtime_dir, ENV_RUNTIME_DIR)
	if override:
		igor = runtime_find_igor(override)
		if not igor:
			raise ToolError(
				f"Igor was not found inside {override}. "
				f"Point {ENV_RUNTIME_DIR} or --runtime-dir at a runtime-<version> folder that holds bin/igor."
			)
		return Runtime(override.name.removeprefix("runtime-"), override, igor)

	installed = runtime_list_installed()
	year = ide_version.split(".")[0]
	matching = [
		runtime for runtime in installed if runtime.version.split(".")[0] == year
	]
	if not matching:
		found = ", ".join(runtime.version for runtime in installed) or "none"
		raise ToolError(
			f"No GameMaker runtime for IDE version {ide_version} was found (installed runtimes: {found}). "
			f"Install the runtime from the GameMaker IDE or set {ENV_RUNTIME_DIR}."
		)
	return max(matching, key=lambda runtime: runtime_get_version_key(runtime.version))


def runtime_get_install_root(runtime):
	directory = runtime.directory
	if directory.parent.name == "runtimes" and directory.parent.parent.name == "Cache":
		return directory.parent.parent.parent
	return None


def runtime_get_user_data_root():
	system = platform.system()
	if system == "Windows":
		return Path(os.environ.get("APPDATA", Path.home() / "AppData/Roaming"))
	if system == "Darwin":
		return Path.home() / "Library/Application Support"
	return Path.home() / ".config"


def runtime_find_licence(directory):
	for name in LICENCE_FILE_NAMES:
		candidate = directory / name
		if candidate.is_file():
			return candidate
	return None


def runtime_find_user_directory(args, runtime):
	override = runtime_get_override(args.user_dir, ENV_USER_DIR)
	if override:
		if not runtime_find_licence(override):
			raise ToolError(
				f"No licence file was found in {override}. Point {ENV_USER_DIR} or --user-dir at the folder that holds licence.plist."
			)
		return override

	install_root = runtime_get_install_root(runtime)
	if install_root is None:
		raise ToolError(
			f"The user folder cannot be derived from {runtime.directory}. Set {ENV_USER_DIR} to the folder that holds licence.plist."
		)

	base = runtime_get_user_data_root() / install_root.name
	licences = []
	if base.is_dir():
		for user_directory in sorted(base.iterdir()):
			licence = (
				runtime_find_licence(user_directory)
				if user_directory.is_dir()
				else None
			)
			if licence:
				licences.append(licence)
	if not licences:
		raise ToolError(
			f"No licence file was found under {base}. Sign in once from the GameMaker IDE or set {ENV_USER_DIR}."
		)
	return max(licences, key=lambda licence: licence.stat().st_mtime).parent


def runtime_find_prefabs(args, runtime):
	override = runtime_get_override(args.prefabs_dir, ENV_PREFABS_DIR)
	if override:
		if not override.is_dir():
			raise ToolError(
				f"{override} is not a folder. Point {ENV_PREFABS_DIR} or --prefabs-dir at the Prefabs folder of the installation."
			)
		return override

	install_root = runtime_get_install_root(runtime)
	prefabs = install_root / PREFABS_DIR_NAME if install_root else None
	if prefabs is None or not prefabs.is_dir():
		raise ToolError(
			f"The Prefabs folder was not found next to the runtime. Open the project once in the GameMaker IDE so it downloads them, or set {ENV_PREFABS_DIR}."
		)
	return prefabs

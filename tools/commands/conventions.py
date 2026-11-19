# Import libraries
import re

# Import modules
from commands.zones import zones_read_baseline
from project import project_find_file, project_get_root
from resources import resources_is_inside, resources_read_parent, resources_read_text

# Constants
BASELINE_FILE = "conventions_baseline.txt"
ITEMS_RULE = "items"
VENDOR_FOLDER = "folders/01. Vendor"
PLAYER_FOLDER = "folders/04. Player"
RESOURCE_TYPES = ("scripts", "objects", "rooms", "sprites", "sounds", "fonts", "tilesets", "notes")
PREFIXES = {
	"objects": ("obj_",),
	"rooms": ("rm_",),
	"sprites": ("spr_",),
	"sounds": ("snd_", "bgm_"),
	"fonts": ("font_",),
	"tilesets": ("ts_",),
}
MAX_ITEMS = 9
MAX_DEPTH = 4
EVENT_TYPES = {
	0: "Create", 1: "Destroy", 2: "Alarm", 3: "Step", 4: "Collision", 5: "Keyboard", 6: "Mouse",
	7: "Other", 8: "Draw", 9: "KeyPress", 10: "KeyRelease", 12: "CleanUp", 13: "Gesture",
}
SNAKE_PATTERN = re.compile(r"^[a-z][a-z0-9]*(?:_[a-z0-9]+)*$")
PASCAL_PATTERN = re.compile(r"^[A-Z][A-Za-z0-9]*$")
CONSTANT_SCRIPT_PATTERN = re.compile(r"^(?:config_\w+|\w+_constants)$")
MACRO_NAME_PATTERN = re.compile(r"^(?:[A-Z][A-Z0-9_]*|vb_[a-z]+)$")
MACRO_PATTERN = re.compile(r"^\s*#macro\s+(\w+)\s+(.*)$")
RESOURCE_VALUE_PATTERN = re.compile(r"^(?:obj|spr|snd|bgm|rm|font|ts)_\w+")
FUNCTION_PATTERN = re.compile(r"^function\s+(\w+)\s*\(", re.MULTILINE)
ANY_FUNCTION_PATTERN = re.compile(r"\bfunction\b\s*\w*\s*\(")
VAR_PATTERN = re.compile(r"\bvar\s+")
EVENT_PATTERN = re.compile(
	r'"collisionObjectId":(?:null|\{"name":"([^"]+)"[^}]*\}),"eventNum":(\d+),"eventType":(\d+)'
)
FOLDER_PATTERN = re.compile(r'"folderPath":"([^"]+)\.yy"')


# Functions
def conventions_strip(text):
	# Blank the comments and the strings and keep every offset and line break
	result = []
	quote = None
	block = False
	index = 0
	while index < len(text):
		char = text[index]
		pair = text[index : index + 2]
		if block:
			if pair == "*/":
				result.append("  ")
				index += 2
				block = False
				continue
			result.append(char if char == "\n" else " ")
		elif quote:
			if char == "\\":
				result.append("  ")
				index += 2
				continue
			if char == quote or char == "\n":
				quote = None
			result.append(char if char == "\n" else " ")
		elif pair == "//":
			while index < len(text) and text[index] != "\n":
				result.append(" ")
				index += 1
			continue
		elif pair == "/*":
			result.append("  ")
			index += 2
			block = True
			continue
		elif char in "\"'":
			quote = char
			result.append(" ")
		else:
			result.append(char)
		index += 1
	return "".join(result)


def conventions_find_close(code, start, opening, closing):
	# Return the offset of the bracket that closes the one at start
	depth = 0
	for index in range(start, len(code)):
		if code[index] == opening:
			depth += 1
		elif code[index] == closing:
			depth -= 1
			if depth == 0:
				return index
	return len(code) - 1


def conventions_split_top_level(text):
	parts = []
	depth = 0
	current = ""
	for char in text:
		if char in "([{":
			depth += 1
		elif char in ")]}":
			depth -= 1
		if char == "," and depth == 0:
			parts.append(current)
			current = ""
		else:
			current += char
	parts.append(current)
	return parts


def conventions_line_of(code, offset):
	return code.count("\n", 0, offset) + 1


def conventions_read_declarations(code):
	# Return the line and the name of every parameter and local variable
	found = []
	for match in ANY_FUNCTION_PATTERN.finditer(code):
		start = match.end() - 1
		end = conventions_find_close(code, start, "(", ")")
		for part in conventions_split_top_level(code[start + 1 : end]):
			name = re.match(r"\s*(\w+)", part)
			if name:
				found.append((conventions_line_of(code, start), name.group(1)))
	for match in VAR_PATTERN.finditer(code):
		end = code.find(";", match.end())
		end = len(code) if end < 0 else end
		for part in conventions_split_top_level(code[match.end() : end]):
			name = re.match(r"\s*(\w+)", part)
			if name:
				found.append((conventions_line_of(code, match.end()), name.group(1)))
	return found


def conventions_list_resources(root):
	resources = []
	for kind in RESOURCE_TYPES:
		if not (root / kind).is_dir():
			continue
		for directory in sorted((root / kind).iterdir()):
			resource = directory / (directory.name + ".yy")
			if resource.exists():
				resources.append((kind, directory, resources_read_parent(resource)))
	return resources


def conventions_read_functions(code):
	# Return the name, whether it is a constructor and the span of each function at the start of a line
	functions = []
	for match in FUNCTION_PATTERN.finditer(code):
		close = conventions_find_close(code, match.end() - 1, "(", ")")
		brace = code.find("{", close)
		is_constructor = "constructor" in code[close:brace]
		functions.append((match.group(1), is_constructor, match.start(), conventions_find_close(code, brace, "{", "}")))
	return functions


def conventions_check_script(root, directory, code):
	# C003, C019 and C026, a script holds one function named like it or only constants
	name = directory.name
	path = (directory / (name + ".gml")).relative_to(root).as_posix()
	problems, warnings = [], []
	if name.startswith("_"):
		problems.append(
			f"[ERROR] {path} starts with an underscore, which S015 keeps for locals, parameters and "
			f"internal names. Rename the script without it."
		)
	functions = conventions_read_functions(code)
	if not functions:
		if "function" in code:
			problems.append(f"[ERROR] {path} declares a function that is not at the start of a line. Put it at the start so the script holds it.")
		elif not CONSTANT_SCRIPT_PATTERN.match(name):
			problems.append(
				f"[ERROR] {path} holds no function, so C026 asks for a name that says what it declares, "
				f"config_<what> or <domain>_constants. Rename it."
			)
		return problems, warnings
	if CONSTANT_SCRIPT_PATTERN.match(name):
		problems.append(f"[ERROR] {path} holds a function, and C026 keeps the names config_<what> and <domain>_constants for scripts with none. Rename it.")
	if len(functions) != 1 or functions[0][0] != name:
		declared = ", ".join(function[0] for function in functions)
		problems.append(f"[ERROR] {path} declares {declared} and a script holds one function named like it (C003). Split it or rename it.")
		return problems, warnings
	_, is_constructor, start, end = functions[0]
	pattern, style = (PASCAL_PATTERN, "PascalCase (C019)") if is_constructor else (SNAKE_PATTERN, "snake_case (C003)")
	if not pattern.match(name):
		problems.append(f"[ERROR] {path} is named {name}, which is not {style}. Rename it.")
	if (code[:start] + code[end + 1 :]).strip():
		warnings.append(f"[WARN] {path} also runs code outside its function when the game starts, which no name or folder shows. Move it or keep it knowingly.")
	return problems, warnings


def conventions_check_code(root, resources):
	problems, warnings = [], []
	player_names = 0
	for directory, parent in resources:
		if resources_is_inside(VENDOR_FOLDER, parent):
			continue
		is_script = directory.parent.name == "scripts"
		for file in sorted(directory.glob("*.gml")):
			path = file.relative_to(root).as_posix()
			text = resources_read_text(file)
			code = conventions_strip(text)
			if is_script and file.stem == directory.name:
				found_problems, found_warnings = conventions_check_script(root, directory, code)
				problems += found_problems
				warnings += found_warnings
			for number, line in enumerate(code.splitlines(), start=1):
				if re.match(r"^\s*return\s*;", line):
					problems.append(f"[ERROR] {path}:{number} returns nothing with return, and C020 asks for exit so the keyword says no value comes back.")
			for number, line in enumerate(text.splitlines(), start=1):
				if re.match(r"^\s*(?:///|/\*)", line):
					problems.append(f"[ERROR] {path}:{number} is a doc or block comment, and C014 asks for a comment of one idea on one line.")
				macro = MACRO_PATTERN.match(line.split("//")[0])
				if not macro:
					continue
				name, value = macro.group(1), macro.group(2).strip()
				if not MACRO_NAME_PATTERN.match(name):
					problems.append(f"[ERROR] {path}:{number} names the macro {name} in lower case, and C021 asks for UPPER_SNAKE_CASE. Rename it.")
				if "global." in value or "(" in value or RESOURCE_VALUE_PATTERN.match(value):
					problems.append(
						f"[ERROR] {path}:{number} makes {name} stand for {value}, and C021 and C027 keep a macro for a "
						f"constant, never for a global, a resource or a call. Write the real name, or add a function."
					)
			for number, name in conventions_read_declarations(code):
				if name.startswith("_"):
					continue
				if resources_is_inside(PLAYER_FOLDER, parent):
					player_names += 1
				else:
					problems.append(f"[ERROR] {path}:{number} declares {name} without a leading underscore, and S015 asks for _{name} on locals and parameters.")
	if player_names:
		warnings.append(
			f"[WARN] {player_names} locals and parameters in {PLAYER_FOLDER} have no leading underscore (S015), "
			f"which waits for the review of its physics in PENDING item 3."
		)
	return problems, warnings


def conventions_check_prefixes(root, resources):
	# S017, a resource name starts with the prefix of its type
	problems = []
	for kind, directory, parent in resources:
		prefixes = PREFIXES.get(kind)
		if not prefixes or resources_is_inside(VENDOR_FOLDER, parent) or directory.name.startswith(prefixes):
			continue
		problems.append(
			f"[ERROR] {directory.relative_to(root).as_posix()} is named {directory.name}, and S017 asks every "
			f"{kind[:-1]} to start with {' or '.join(prefixes)}. Rename it."
		)
	return problems


def conventions_check_events(root, resources):
	# An event file that its object does not list is never compiled
	problems = []
	for directory, parent in resources:
		if directory.parent.name != "objects" or resources_is_inside(VENDOR_FOLDER, parent):
			continue
		listed = set()
		for target, number, kind in EVENT_PATTERN.findall(resources_read_text(directory / (directory.name + ".yy"))):
			name = EVENT_TYPES.get(int(kind), kind)
			listed.add(f"{name}_{target}" if target else f"{name}_{number}")
		for file in sorted(directory.glob("*.gml")):
			if file.stem not in listed:
				problems.append(
					f"[ERROR] {file.relative_to(root).as_posix()} is not an event of {directory.name}, so GameMaker "
					f"never compiles it. Delete it or add the event in the IDE."
				)
	return problems


def conventions_check_folders(root, resources):
	# S003, S005, S006 and S012 over the folders that are not Vendor
	baseline = zones_read_baseline(root / "tools" / BASELINE_FILE)
	declared = sorted(set(FOLDER_PATTERN.findall(resources_read_text(project_find_file(root)))))
	folders = [folder for folder in declared if not resources_is_inside(VENDOR_FOLDER, folder)]
	children = {folder: [] for folder in folders}
	for folder in folders:
		parent = folder.rsplit("/", 1)[0]
		if parent in children:
			children[parent].append(folder)
	resource_parents = {}
	for _, _, parent in resources:
		resource_parents[parent] = resource_parents.get(parent, 0) + 1
	problems = []
	for folder in folders:
		name = folder.rsplit("/", 1)[1]
		items = len(children[folder]) + resource_parents.get(folder, 0)
		if not re.match(r"^\d\d\. \S", name):
			problems.append(f"[ERROR] {folder} is not named NN. Name, and S003 asks for it so the order shows in the IDE.")
		if folder.count("/") > MAX_DEPTH:
			problems.append(f"[ERROR] {folder} is deeper than {MAX_DEPTH} levels, and S005 stops there. Flatten it.")
		if children[folder] and resource_parents.get(folder):
			problems.append(f"[ERROR] {folder} holds folders and resources together, and S012 keeps them apart. Move the resources into a folder.")
		allowed = baseline.get((folder, ITEMS_RULE), MAX_ITEMS)
		if items > allowed:
			problems.append(f"[ERROR] {folder} holds {items} items where {allowed} are allowed (S006). Split it by responsibility.")
		elif items < allowed and (folder, ITEMS_RULE) in baseline:
			problems.append(f"[ERROR] {folder} holds {items} items and {BASELINE_FILE} allows {allowed}. Lower or delete that line so the count cannot grow back.")
	return problems


def conventions_check(resources):
	root = project_get_root()
	everything = conventions_list_resources(root)
	problems, warnings = conventions_check_code(root, resources)
	problems += conventions_check_prefixes(root, everything)
	problems += conventions_check_events(root, resources)
	problems += conventions_check_folders(root, everything)
	return problems, warnings

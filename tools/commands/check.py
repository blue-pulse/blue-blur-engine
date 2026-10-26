# Import libraries
import re

# Import modules
from project import project_find_file, project_get_root

# Constants
VENDOR_FOLDER = "folders/01. Vendor"
ADAPTERS_FOLDER = "folders/02. Core/09. Adapters"
EXEMPT_LIBRARIES = {"GMUtils"}
RESOURCE_FOLDERS = ("scripts", "objects", "rooms")
PARENT_PATTERN = re.compile(r'"parent"\s*:\s*\{[^}]*?"path"\s*:\s*"([^"]+)"')
LIBRARY_PATTERN = re.compile(r"^folders/01\. Vendor/([^/]+?)(?: v?\d[\w.]*)?(?:/|$)")
DECLARATION_PATTERN = re.compile(
	r"^\s*(?:static\s+)?(?:function\s+(\w+)\s*\(|enum\s+(\w+)|#macro\s+(\w+))",
	re.MULTILINE,
)
WORD_PATTERN = re.compile(r"\w+")


# Functions
def check_read_text(path):
	return path.read_text(encoding="utf-8", errors="replace")


def check_read_parent(resource):
	match = PARENT_PATTERN.search(check_read_text(resource))
	return match.group(1).removesuffix(".yy") if match else ""


def check_is_inside(folder, parent):
	return parent == folder or parent.startswith(folder + "/")


def check_list_resources(root):
	resources = []
	for folder in RESOURCE_FOLDERS:
		for resource in sorted((root / folder).glob("*/*.yy")):
			resources.append((resource.parent, check_read_parent(resource)))
	return resources


def check_collect_symbols(resources):
	symbols = {}
	for directory, parent in resources:
		match = LIBRARY_PATTERN.match(parent)
		if not match or match.group(1) in EXEMPT_LIBRARIES:
			continue
		library = match.group(1)
		symbols.setdefault(directory.name, library)
		for code in directory.glob("*.gml"):
			for declaration in DECLARATION_PATTERN.findall(check_read_text(code)):
				for name in filter(None, declaration):
					symbols.setdefault(name, library)
	return symbols


def check_find_uses(root, resources, symbols):
	uses = []
	for directory, parent in resources:
		if check_is_inside(VENDOR_FOLDER, parent):
			continue
		adapter = None
		if check_is_inside(ADAPTERS_FOLDER, parent):
			adapter = parent[len(ADAPTERS_FOLDER) + 1 :].split("/")[0]
		for code in sorted(directory.glob("*.gml")):
			path = code.relative_to(root).as_posix()
			lines = check_read_text(code).splitlines()
			for number, line in enumerate(lines, start=1):
				found = set()
				for word in WORD_PATTERN.findall(line.split("//")[0]):
					library = symbols.get(word)
					if library and library not in found:
						found.add(library)
						uses.append((path, number, word, library, adapter))
	return uses


def check_boundaries(args):
	root = project_get_root()
	project_find_file(root)

	resources = check_list_resources(root)
	symbols = check_collect_symbols(resources)
	uses = check_find_uses(root, resources, symbols)

	adapters = {}
	for _, _, _, library, adapter in uses:
		if adapter:
			adapters.setdefault(library, set()).add(adapter)

	violations = []
	direct = {}
	for path, number, word, library, adapter in uses:
		if adapter:
			continue
		if library in adapters:
			violations.append(
				f"[ERROR] {path}:{number} uses {word} of {library}, which has its "
				f"adapter in {', '.join(sorted(adapters[library]))}, so only that "
				f"adapter and Vendor may use it. Call the adapter function instead."
			)
		else:
			direct.setdefault(library, set()).add(path)

	for violation in violations:
		print(violation)
	for library, paths in sorted(direct.items()):
		print(
			f"[WARN] {library} is called from {len(paths)} files and has no adapter, "
			f"which E002 asks for. Add one in {ADAPTERS_FOLDER}."
		)
	if violations:
		print(f"[ERROR] {len(violations)} library symbols found outside their adapter")
		return 1
	print(
		f"[INFO] Checked {len(resources)} resources against {len(symbols)} library "
		f"symbols, and {len(adapters)} libraries are only used in their adapters"
	)
	return 0

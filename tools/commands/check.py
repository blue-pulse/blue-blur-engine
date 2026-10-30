# Import libraries
import re

# Import modules
from project import project_find_file, project_get_root
from resources import resources_is_inside, resources_list, resources_read_text
from commands.fitness import fitness_check
from commands.zones import zones_check

# Constants
VENDOR_FOLDER = "folders/01. Vendor"
ADAPTERS_FOLDER = "folders/02. Core/09. Adapters"
EXEMPT_LIBRARIES = {"GMUtils"}
LIBRARY_PATTERN = re.compile(r"^folders/01\. Vendor/([^/]+?)(?: v?\d[\w.]*)?(?:/|$)")
DECLARATION_PATTERN = re.compile(
	r"^\s*(?:static\s+)?(?:function\s+(\w+)\s*\(|enum\s+(\w+)|#macro\s+(\w+))",
	re.MULTILINE,
)
WORD_PATTERN = re.compile(r"\w+")


# Functions
def check_collect_symbols(resources):
	symbols = {}
	for directory, parent in resources:
		match = LIBRARY_PATTERN.match(parent)
		if not match or match.group(1) in EXEMPT_LIBRARIES:
			continue
		library = match.group(1)
		symbols.setdefault(directory.name, library)
		for code in directory.glob("*.gml"):
			for declaration in DECLARATION_PATTERN.findall(resources_read_text(code)):
				for name in filter(None, declaration):
					symbols.setdefault(name, library)
	return symbols


def check_find_uses(root, resources, symbols):
	uses = []
	for directory, parent in resources:
		if resources_is_inside(VENDOR_FOLDER, parent):
			continue
		adapter = None
		if resources_is_inside(ADAPTERS_FOLDER, parent):
			adapter = parent[len(ADAPTERS_FOLDER) + 1 :].split("/")[0]
		for code in sorted(directory.glob("*.gml")):
			path = code.relative_to(root).as_posix()
			lines = resources_read_text(code).splitlines()
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

	resources = resources_list(root)
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

	zone_problems = zones_check(resources) + fitness_check(resources)
	for violation in violations + zone_problems:
		print(violation)
	for library, paths in sorted(direct.items()):
		print(
			f"[WARN] {library} is called from {len(paths)} files and has no adapter, "
			f"which E002 asks for. Add one in {ADAPTERS_FOLDER}."
		)
	if violations:
		print(f"[ERROR] {len(violations)} library symbols found outside their adapter")
	if zone_problems:
		print(f"[ERROR] {len(zone_problems)} presentation, animation or time rules broken")
	if violations or zone_problems:
		return 1
	print(
		f"[INFO] Checked {len(resources)} resources against {len(symbols)} library "
		f"symbols, and {len(adapters)} libraries are only used in their adapters"
	)
	return 0

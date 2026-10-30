# Import libraries
import re

# Constants
RESOURCE_FOLDERS = ("scripts", "objects", "rooms")
PARENT_PATTERN = re.compile(r'"parent"\s*:\s*\{[^}]*?"path"\s*:\s*"([^"]+)"')


# Functions
def resources_read_text(path):
	return path.read_text(encoding="utf-8", errors="replace")


def resources_read_parent(resource):
	match = PARENT_PATTERN.search(resources_read_text(resource))
	return match.group(1).removesuffix(".yy") if match else ""


def resources_is_inside(folder, parent):
	return parent == folder or parent.startswith(folder + "/")


def resources_list(root):
	resources = []
	for folder in RESOURCE_FOLDERS:
		for resource in sorted((root / folder).glob("*/*.yy")):
			resources.append((resource.parent, resources_read_parent(resource)))
	return resources

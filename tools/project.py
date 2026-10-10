# Import libraries
import re
from pathlib import Path

# Import modules
from errors import ToolError

# Constants
SANDBOX_DIR_NAME = ".sandbox"
IDE_VERSION_PATTERN = re.compile(r'"IDEVersion"\s*:\s*"([^"]+)"')


# Functions
def project_get_root():
	return Path(__file__).resolve().parent.parent


def project_find_file(root):
	files = sorted(root.glob("*.yyp"))
	if len(files) != 1:
		raise ToolError(
			f"Expected one .yyp file in {root} and found {len(files)}. "
			"Run the tools from a checkout that keeps the GameMaker project at its root."
		)
	return files[0]


def project_read_ide_version(project_file):
	match = IDE_VERSION_PATTERN.search(project_file.read_text(encoding="utf-8"))
	if not match:
		raise ToolError(
			f"{project_file.name} has no IDEVersion, so the matching runtime cannot be chosen. "
			"Open the project once in the GameMaker IDE so it writes the version."
		)
	return match.group(1)


def project_get_sandbox(root):
	directory = root / SANDBOX_DIR_NAME
	directory.mkdir(exist_ok=True)
	return directory

# Import libraries
import platform

# Import modules
from errors import ToolError
from project import (
	project_find_file,
	project_get_root,
	project_get_sandbox,
	project_read_ide_version,
)
from runtime import (
	runtime_find,
	runtime_find_prefabs,
	runtime_find_user_directory,
	runtime_warn_if_unverified,
)


# Functions
def doctor_attempt(find):
	try:
		return find()
	except ToolError as error:
		print(f"[ERROR] {error}")
		return None


def doctor_check(args):
	print(
		f"[INFO] Operating system {platform.system()}, Python {platform.python_version()}"
	)
	runtime_warn_if_unverified()

	root = project_get_root()
	project_file = doctor_attempt(lambda: project_find_file(root))
	ide_version = (
		doctor_attempt(lambda: project_read_ide_version(project_file))
		if project_file
		else None
	)
	if not ide_version:
		return 1
	print(
		f"[INFO] Project {project_file.name} was saved with IDE version {ide_version}"
	)

	found = []
	runtime = doctor_attempt(lambda: runtime_find(args, ide_version))
	if runtime:
		print(f"[INFO] Runtime {runtime.version} at {runtime.directory}")
		user_directory = doctor_attempt(
			lambda: runtime_find_user_directory(args, runtime)
		)
		if user_directory:
			print(f"[INFO] Licence folder {user_directory}")
		prefabs_directory = doctor_attempt(lambda: runtime_find_prefabs(args, runtime))
		if prefabs_directory:
			print(f"[INFO] Prefabs folder {prefabs_directory}")
		found = [user_directory, prefabs_directory]
	else:
		print(
			"[WARNING] The licence and Prefabs checks wait until the runtime is found"
		)

	print(f"[INFO] Temporary folder {project_get_sandbox(root)}")

	if runtime and all(found):
		print("[INFO] Everything needed to run was found")
		return 0
	return 1

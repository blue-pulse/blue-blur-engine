# Import libraries
from igor import IGOR_ACTION_RUN, igor_build_command, igor_prepare_directories, igor_run
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

# Constants
RUN_WORK_DIR_NAME = "igor"


# Functions
def run_game(args):
	runtime_warn_if_unverified()
	root = project_get_root()
	project_file = project_find_file(root)
	runtime = runtime_find(args, project_read_ide_version(project_file))
	user_directory = runtime_find_user_directory(args, runtime)
	prefabs_directory = runtime_find_prefabs(args, runtime)

	work_directory = project_get_sandbox(root) / RUN_WORK_DIR_NAME
	igor_prepare_directories(work_directory)
	command = igor_build_command(
		runtime,
		user_directory,
		prefabs_directory,
		project_file,
		work_directory,
		IGOR_ACTION_RUN,
	)

	print(
		f"[INFO] Starting Igor with runtime {runtime.version}, close the game window to finish"
	)
	return igor_run(command, root)

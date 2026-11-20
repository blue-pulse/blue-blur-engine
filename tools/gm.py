# Import libraries
import argparse
import sys

# Import modules
from commands.check import check_boundaries
from commands.doctor import doctor_check
from commands.run import run_game
from commands.saves import saves_add_arguments, saves_show
from errors import ToolError
from runtime import runtime_add_arguments

# Constants
COMMANDS = {
    "doctor": (doctor_check, "Show what was found and what is missing", runtime_add_arguments),
    "run": (run_game, "Run the game with Igor", runtime_add_arguments),
    "check": (check_boundaries, "Check the library boundary, the animation rules and the conventions", None),
    "saves": (saves_show, "Decode and show the save files of the game", saves_add_arguments),
}


# Functions
def gm_dispatch():
    parser = argparse.ArgumentParser(
        description="Check and run Blue Blur Engine with Igor"
    )
    subparsers = parser.add_subparsers(dest="command", required=True)
    for name, (function, description, add_arguments) in COMMANDS.items():
        subparser = subparsers.add_parser(name, help=description)
        if add_arguments:
            add_arguments(subparser)
        subparser.set_defaults(function=function)

    args = parser.parse_args()
    try:
        return args.function(args)
    except ToolError as error:
        print(f"[ERROR] {error}")
        return 1


# Entry point
if __name__ == "__main__":
    sys.exit(gm_dispatch())

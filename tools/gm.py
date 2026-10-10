# Import libraries
import argparse
import sys

# Import modules
from commands.doctor import doctor_check
from commands.run import run_game
from errors import ToolError
from runtime import runtime_add_arguments

# Constants
COMMANDS = {
    "doctor": (doctor_check, "Show what was found and what is missing"),
    "run": (run_game, "Run the game with Igor"),
}


# Functions
def gm_dispatch():
    parser = argparse.ArgumentParser(
        description="Check and run Blue Blur Engine with Igor"
    )
    subparsers = parser.add_subparsers(dest="command", required=True)
    for name, (function, description) in COMMANDS.items():
        subparser = subparsers.add_parser(name, help=description)
        runtime_add_arguments(subparser)
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

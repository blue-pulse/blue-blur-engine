# Import libraries
import re

# Import modules
from commands.zones import BASELINE_FILE, zones_read_baseline
from project import project_find_file, project_get_root
from resources import PARENT_PATTERN, resources_is_inside, resources_read_text

# Constants
CORE_FOLDER = "folders/02. Core"
VENDOR_FOLDER = "folders/01. Vendor"
PRESENTATION_CORE_FOLDER = "folders/02. Core/06. Display/03. Presentation"
SELECTORS_FOLDER = PRESENTATION_CORE_FOLDER + "/02. Selectors"
SELECTOR_PREFIX = "selector_"
MAX_SELECTOR_BRANCHES = 6
NAME_PATTERN = re.compile(r"^(?:anim|spr|snd|obj)_\w+$")
BRANCH_PATTERN = re.compile(r"\b(?:if|for|while|switch|case)\b|\?")
FUNCTION_PATTERN = re.compile(r"^\s*function\s+(\w+)\s*\(", re.MULTILINE)
WORD_PATTERN = re.compile(r"\w+")
FOLDER_PATTERN = re.compile(r'"folderPath":"([^"]+)\.yy"')
PLAYER_FOLDER = "folders/04. Player"
STATES_FOLDER = "folders/04. Player/01. Base/02. States"
CHARACTER_PATTERN = re.compile(r"^folders/04\. Player/(?!01\. )\d\d\. [^/]+")
CHARACTER_RULE = "character"
FALLBACKS_SCRIPT = "player_define_fallbacks"
REQUIRED_CLIP = "idle"
STATES_WITHOUT_ROW = {"player_state_debug", "player_state_init", "player_state_lock"}
ROW_PATTERN = re.compile(r"\bstate:\s*(player_state_\w+)")
CLIP_PATTERN = re.compile(r"\bclips\.(\w+)")
FALLBACK_PATTERN = re.compile(r'^\s*(\w+):\s*"(\w+)",', re.MULTILINE)
SPRITE_PATTERN = re.compile(r"\banimation_create\(\s*(spr_\w+)")


# Functions
def fitness_read_code(path):
	lines = resources_read_text(path).splitlines()
	return [line.split("//")[0] for line in lines]


def fitness_check_names(root, resources):
	# C1, the shared presentation names nothing outside Core and Vendor
	owners = {directory.name: parent for directory, parent in resources}
	problems = []
	for directory, parent in resources:
		if not resources_is_inside(PRESENTATION_CORE_FOLDER, parent):
			continue
		for code in sorted(directory.glob("*.gml")):
			path = code.relative_to(root).as_posix()
			for number, line in enumerate(fitness_read_code(code), start=1):
				for word in set(WORD_PATTERN.findall(line)):
					owner = owners.get(word)
					outside = owner is not None and not (
						resources_is_inside(CORE_FOLDER, owner) or resources_is_inside(VENDOR_FOLDER, owner)
					)
					if outside or NAME_PATTERN.match(word) and owner is None:
						problems.append(
							f"[ERROR] {path}:{number} names {word}, which belongs to a character, "
							f"an enemy or the art, and the shared presentation may only name what is "
							f"in Core. Read it from the row or the facts that the character gives."
						)
	return problems


def fitness_check_selectors(root, resources):
	# C3, one function per selector script and a limit of branches
	problems = []
	for directory, parent in resources:
		if not resources_is_inside(SELECTORS_FOLDER, parent):
			continue
		for code in sorted(directory.glob("*.gml")):
			path = code.relative_to(root).as_posix()
			text = "\n".join(fitness_read_code(code))
			functions = FUNCTION_PATTERN.findall(text)
			if functions != [directory.name] or not directory.name.startswith(SELECTOR_PREFIX):
				problems.append(
					f"[ERROR] {path} holds {functions} and a selector script must hold exactly one "
					f"function named like the script, starting with {SELECTOR_PREFIX}. Split it so "
					f"each selector can be replaced alone."
				)
			branches = len(BRANCH_PATTERN.findall(text))
			if branches > MAX_SELECTOR_BRANCHES:
				problems.append(
					f"[ERROR] {path} has {branches} branches and a selector may have "
					f"{MAX_SELECTOR_BRANCHES}. Split it into two selectors so each stays easy to read."
				)
	return problems


def fitness_check_folders(root, resources):
	# Every resource sits in a folder that the project file declares
	declared = set(FOLDER_PATTERN.findall(resources_read_text(project_find_file(root))))
	problems = []
	for directory, _ in resources:
		resource = directory / (directory.name + ".yy")
		match = PARENT_PATTERN.search(resources_read_text(resource))
		if not match:
			continue
		path = match.group(1)
		if not path.endswith(".yy") or path.removesuffix(".yy") not in declared:
			problems.append(
				f"[ERROR] {resource.relative_to(root).as_posix()} says its folder is {path}, which the project "
				f"file does not declare, so the game would not load. Use a folderPath of the project "
				f"file, ending in .yy."
			)
	return problems


def fitness_find_code(root, resources, folder):
	for directory, parent in resources:
		if resources_is_inside(folder, parent):
			for code in sorted(directory.glob("*.gml")):
				yield directory, parent, code, code.relative_to(root).as_posix()


def fitness_check_characters(root, resources):
	# C2, nothing outside a character names what is inside it, with the old uses frozen
	baseline = zones_read_baseline(root / "tools" / BASELINE_FILE)
	owners = {}
	for directory, parent in resources:
		match = CHARACTER_PATTERN.match(parent)
		if match:
			owners[directory.name] = match.group(0)
	hits = {}
	for directory, parent in resources:
		if resources_is_inside(VENDOR_FOLDER, parent):
			continue
		for code in sorted(directory.glob("*.gml")):
			path = code.relative_to(root).as_posix()
			for number, line in enumerate(fitness_read_code(code), start=1):
				for word in set(WORD_PATTERN.findall(line)):
					folder = owners.get(word)
					if folder and not resources_is_inside(folder, parent):
						hits.setdefault((path, CHARACTER_RULE), []).append((number, word))
	problems = []
	for key, found in sorted(hits.items()):
		allowed = baseline.get(key, 0)
		if len(found) > allowed:
			where = ", ".join(f"line {number} ({word})" for number, word in found)
			problems.append(
				f"[ERROR] {key[0]} names {len(found)} resources of a character where {allowed} are allowed: "
				f"{where}. A character may depend on the base, and the base may not depend on a character."
			)
	for key, allowed in sorted(baseline.items()):
		if key[1] == CHARACTER_RULE and len(hits.get(key, [])) < allowed:
			problems.append(
				f"[ERROR] {key[0]} has {len(hits.get(key, []))} character uses and {BASELINE_FILE} allows "
				f"{allowed}. Lower or delete that line so the count cannot grow back."
			)
	return problems


def fitness_check_clips(root, resources):
	# C5, the rows, the clips, the fallbacks and the sprites agree before the game starts
	problems = []
	states = {directory.name for directory, parent in resources if resources_is_inside(STATES_FOLDER, parent)}
	rows, used, fallbacks = {}, {}, {}
	for directory, parent, code, path in fitness_find_code(root, resources, PLAYER_FOLDER):
		text = "\n".join(fitness_read_code(code))
		for state in ROW_PATTERN.findall(text):
			rows.setdefault(state, path)
		for clip in CLIP_PATTERN.findall(text):
			if "create_presentation" in directory.name:
				used.setdefault(clip, path)
		if directory.name == FALLBACKS_SCRIPT:
			fallbacks = dict(FALLBACK_PATTERN.findall(text))
		if CHARACTER_PATTERN.match(parent) and "animation_create(" in text and not re.search(r"\bclips\." + REQUIRED_CLIP + r"\s*=", text):
			problems.append(
				f"[ERROR] {path} builds the animations of a character and has no {REQUIRED_CLIP}, which every "
				f"fallback leads to. Add clips.{REQUIRED_CLIP} so the character has something to play."
			)
	for state in sorted(states - STATES_WITHOUT_ROW - set(rows)):
		problems.append(f"[ERROR] {state} has no row in the presentation, so it would keep the last animation. Add a row for it.")
	for state, path in sorted(rows.items()):
		if state not in states:
			problems.append(f"[ERROR] {path} has a row for {state}, which is not a state. Fix the name or remove the row.")
	for clip, path in sorted(used.items()):
		if clip != REQUIRED_CLIP and clip not in fallbacks:
			problems.append(f"[ERROR] {path} plays clips.{clip}, which has no fallback in {FALLBACKS_SCRIPT}, so a character without it would crash. Add it to the table.")
	for clip, fallback in sorted(fallbacks.items()):
		seen, step = {clip}, fallback
		while step in fallbacks and step not in seen:
			seen.add(step)
			step = fallbacks[step]
		if step != REQUIRED_CLIP:
			problems.append(f"[ERROR] The fallback of {clip} never reaches {REQUIRED_CLIP} (it stops at {step}). Break the cycle or add the missing entry.")
	sprites = {path.name for path in (root / "sprites").iterdir()}
	for directory, parent in resources:
		if resources_is_inside(VENDOR_FOLDER, parent):
			continue
		for code in sorted(directory.glob("*.gml")):
			for sprite in SPRITE_PATTERN.findall("\n".join(fitness_read_code(code))):
				if sprite not in sprites:
					problems.append(f"[ERROR] {code.relative_to(root).as_posix()} builds an animation from {sprite}, which is not a sprite of the project. Fix the name.")
	return problems


def fitness_check(resources):
	root = project_get_root()
	return (
		fitness_check_names(root, resources)
		+ fitness_check_selectors(root, resources)
		+ fitness_check_folders(root, resources)
		+ fitness_check_characters(root, resources)
		+ fitness_check_clips(root, resources)
	)

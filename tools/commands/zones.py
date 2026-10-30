# Import libraries
import re

# Import modules
from project import project_get_root
from resources import resources_is_inside, resources_read_text

# Constants
BASELINE_FILE = "zones_baseline.txt"
VENDOR_FOLDER = "folders/01. Vendor"
ANIMATION_ADAPTER_FOLDER = "folders/02. Core/09. Adapters/04. Animation"
PRESENTATION_PATTERN = re.compile(r"(?:^|/)\d\d\. Presentation(?:/|$)")
TIME_FOLDERS = (
	ANIMATION_ADAPTER_FOLDER,
	VENDOR_FOLDER,
	"folders/02. Core/01. Bootstrap",
	"folders/02. Core/06. Display",
	"folders/02. Core/08. Tooling",
)
REQUEST_WORDS = {
	"animation_add_transition",
	"animation_create",
	"animation_debug_draw",
	"animation_free",
	"animation_init",
	"animation_play",
	"animation_update",
}
QUERY_WORDS = {
	"animation",
	"animation_is_playing",
}
TIME_WORDS = {
	"current_time",
	"delta_time",
	"fps",
	"fps_real",
	"game_get_speed",
	"get_timer",
	"room_speed",
}
ZONE_RULES = ("request", "query", "name", "time")
NAME_PATTERN = re.compile(r"^anim_\w+$")
WORD_PATTERN = re.compile(r"\w+")


# Functions
def zones_read_baseline(path):
	baseline = {}
	if not path.exists():
		return baseline
	for line in path.read_text(encoding="utf-8").splitlines():
		if not line.strip() or line.startswith("#"):
			continue
		file, rule, count = line.rsplit(" ", 2)
		baseline[(file, rule)] = int(count)
	return baseline


def zones_is_presentation(parent):
	return resources_is_inside(ANIMATION_ADAPTER_FOLDER, parent) or bool(
		PRESENTATION_PATTERN.search(parent)
	)


def zones_classify(word, parent):
	if not zones_is_presentation(parent):
		if word in QUERY_WORDS:
			return "query"
		if word in REQUEST_WORDS:
			return "request"
		if NAME_PATTERN.match(word):
			return "name"
	allowed_time = zones_is_presentation(parent) or any(
		resources_is_inside(folder, parent) for folder in TIME_FOLDERS
	)
	if word in TIME_WORDS and not allowed_time:
		return "time"
	return None


def zones_count_hits(root, resources):
	hits = {}
	for directory, parent in resources:
		if resources_is_inside(VENDOR_FOLDER, parent):
			continue
		for code in sorted(directory.glob("*.gml")):
			path = code.relative_to(root).as_posix()
			lines = resources_read_text(code).splitlines()
			for number, line in enumerate(lines, start=1):
				for word in set(WORD_PATTERN.findall(line.split("//")[0])):
					rule = zones_classify(word, parent)
					if rule:
						hits.setdefault((path, rule), []).append((number, word))
	return hits


def zones_check(resources):
	root = project_get_root()
	baseline = zones_read_baseline(root / "tools" / BASELINE_FILE)
	hits = zones_count_hits(root, resources)

	problems = []
	for key, found in sorted(hits.items()):
		allowed = baseline.get(key, 0)
		if len(found) > allowed:
			path, rule = key
			where = ", ".join(f"line {number} ({word})" for number, word in found)
			problems.append(
				f"[ERROR] {path} has {len(found)} {rule} uses of animation or time where "
				f"{allowed} are allowed: {where}. Keep animation and time out of the game "
				f"logic and publish the fact in the presentation record instead."
			)
	for key, allowed in sorted(baseline.items()):
		if key[1] in ZONE_RULES and len(hits.get(key, [])) < allowed:
			path, rule = key
			problems.append(
				f"[ERROR] {path} has {len(hits.get(key, []))} {rule} uses and "
				f"{BASELINE_FILE} allows {allowed}. Lower or delete that line so the "
				f"count cannot grow back."
			)
	return problems

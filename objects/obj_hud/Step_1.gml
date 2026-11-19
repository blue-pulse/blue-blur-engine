// Increase stage timer
if (allow_time_update) {
	global.time++;
}

// Force visibility
else if (force_visibility and !scene_is_changing()) {
	is_visible = true;
	force_visibility = false;
}

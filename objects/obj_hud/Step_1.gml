// Increase stage timer
if (update_time) {
	global.time++;
}

// Force visibility
else if (force_visibility and !scene_is_changing()) {
	viewable = true;
	force_visibility = false;
}

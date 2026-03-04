// Increase stage timer
if (update_time) {
	global.time++;
}

// Force visibility
else if (force_visibility and !is_fading) {
	viewable = true;
	force_visibility = false;
}

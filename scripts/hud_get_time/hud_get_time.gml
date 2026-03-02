function hud_get_time() {
	// Variables
	var time = global.time;
	var minutes = 9;
	var seconds = 59;
	var microseconds = 59;

	// Calculate timer values
	if (time < 35999) {
		minutes = floor(time / 3600);
		seconds = floor((time - minutes * 3600) / 60);
		microseconds = floor(time % 60 / 3 * 5);
	}

	// Return string
	return int_to_text(minutes, 2) + ":" + int_to_text(seconds, 2) + "." + int_to_text(microseconds, 2);
}

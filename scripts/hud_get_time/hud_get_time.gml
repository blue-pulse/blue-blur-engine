function hud_get_time() {
	// Variables
	var timer = global.frame_counter;
	var minutes = 9;
	var seconds = 59;
	var microseconds = 59;

	// Calculate timer values
	if (timer < 35999) {
		minutes = floor(timer / 3600);
		seconds = floor((timer - minutes * 3600) / 60);
		microseconds = floor(timer % 60 / 3 * 5);
	}

	// Return string
	return int_to_text(minutes, 2) + ":" + int_to_text(seconds, 2) + "." + int_to_text(microseconds, 2);
}

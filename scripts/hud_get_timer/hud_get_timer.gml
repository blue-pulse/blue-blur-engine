function hud_get_timer() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Variables
	var _time = global.time;
	var _minutes = 9;
	var _seconds = 59;
	var _microseconds = 59;

	// Calculate timer values
	if (_time < 35999) {
		_minutes = floor(_time / 3600);
		_seconds = floor((_time - _minutes * 3600) / 60);
		_microseconds = floor(_time % 60 / 3 * 5);
	}

	// Return string
	return int_to_text(_minutes, 2) + ":" + int_to_text(_seconds, 2) + "." + int_to_text(_microseconds, 2);
}

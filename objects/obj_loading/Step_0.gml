// Hide in rooms without the indicator
if (room == rm_pause or
	room == rm_init_game or
	room == rm_stop_game
) {
	is_shown = false;
	is_holding = false;
	alarm_set(0, -1);
	exit;
}

// Show while the storage is busy
var _is_busy = storage_is_busy();
if (_is_busy and !is_shown) {
	is_shown = true;
	is_holding = true;
	alarm_set(0, hold_steps);
}

// Hide when the storage is idle and the minimum time has passed
else if (!_is_busy and is_shown and !is_holding) {
	is_shown = false;
}

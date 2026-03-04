function stage_restart_game(_duration=10) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Lock player
	input_disable_device();
	camera_set_target(noone);
	
	// Checkpoint data
	global.checkpoint.timecount = 0;
	global.checkpoint.scoring = 0;
	global.checkpoint.room_pos = [0, 0];
	global.checkpoint.hub_pos = [0, 0];
	
	// Logic
	with (Stage) {
		alarm_set(3, _duration);
	}
}

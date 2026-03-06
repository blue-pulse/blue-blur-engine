function stage_restart_game(_duration=10) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Lock player
	input_disable_device();
	camera_set_target(noone);
	
	// Schedule exit
	with (Stage) {
		alarm_set(3, _duration);	
	}
	
	// Save current data
	file_save_userdata();
	game_reset_checkpoint(true);
}

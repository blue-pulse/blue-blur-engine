function stage_exit_room(_duration=15) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Lock player
	input_disable_device();
	camera_set_target(noone);
	
	// Checkpoint data
	global.checkpoint.reset();
	
	// Schedule exit
	with (Stage) {
		alarm_set(1, _duration);
	}
}

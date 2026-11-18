function stage_restart_room(_duration=10) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Lock player
	input_disable();
	camera_set_target(noone);
		
	// Checkpoint data
	global.checkpoint.reset();
	
	// Schedule exit
	with (obj_stage_manager) {
		alarm_set(2, _duration);
	}
}

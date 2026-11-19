function stage_exit_room(_duration=15) {
	// Lock player
	input_disable();
	camera_set_target(noone);
	
	// Checkpoint data
	global.checkpoint.reset();
	
	// Schedule exit
	with (obj_stage_manager) {
		alarm_set(1, _duration);
	}
}

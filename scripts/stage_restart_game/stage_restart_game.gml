function stage_restart_game(_duration=10) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Lock player
	input_disable_device();
	camera_set_target(noone);
	
	// Write data to database
	db_write(global.userdata, global.slot, "slot");
	db_write(global.savedata, {
		slot: global.slot,
		playtime: ticks,
		character: global.character,
		life: global.lives,
		position: global.checkpoint.get_hub(),
	});
	global.checkpoint.reset_all();
	
	// Schedule saving
	file_save_userdata();
	file_save_savedata(global.slot);
	
	// Schedule exit
	with (Stage) {
		alarm_set(3, _duration);	
	}
}

function game_load_config() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Load the last saved slot
	var config = file_get_config();
	var last_slot = config.get("last");
	
	// Load user data
	file_load_userdata(last_slot);
	
	// Set config data
	is_fullscreen = config.get("graphics").fullscreen;
	global.master_volume = config.get("sound").master;
	global.bgm_volume = config.get("sound").master;
	global.sfx_volume = config.get("sound").sfx;
	global.voices_volume = config.get("sound").voices;
}

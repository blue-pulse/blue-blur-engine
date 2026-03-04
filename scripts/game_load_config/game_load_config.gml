function game_load_config() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// TODO
	
	// Game
	is_fullscreen = false;
	global.master_volume = 1;
	global.bgm_volume = 1;
	global.sfx_volume = 1
	global.voices_volume = 1;
	
	// Player
	global.character = obj_sonic;
	global.lives = 3;
}

function game_init_params() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Global parameters
	global.game_has_started = false;

	// Player 
	global.character = obj_sonic;
	global.protagonist = noone;
	global.score = 0;

	// Checkpoint data
	global.checkpoint.timecount = 0;
	global.checkpoint.scoring = 0;
	global.checkpoint.room_pos = [0, 0];
	global.checkpoint.hub_pos = [0, 0];
}

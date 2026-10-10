function player_add_lives(amount) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	global.lives = min(global.lives + amount, 99);
	mixer_play_effect(snd_player_life, REPLACE);
}

function player_add_lives(amount) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	global.lives = min(global.lives + amount, 99);
	audio_play_sfx(snd_player_life, REPLACE);
}

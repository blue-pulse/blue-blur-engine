function player_sound_steps() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return mixer_play_effect(snd_player_skid);
}

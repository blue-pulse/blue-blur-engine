function player_sound_skid() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return mixer_play_effect(snd_player_skid);
}

function player_sound_skid() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return audio_play_sfx(snd_player_skid);
}

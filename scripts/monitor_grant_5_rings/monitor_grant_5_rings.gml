function monitor_grant_5_rings() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Give reward
	player_add_rings(5);
	audio_play_sfx(snd_ring_left);
	audio_play_sfx(snd_ring_right);
}

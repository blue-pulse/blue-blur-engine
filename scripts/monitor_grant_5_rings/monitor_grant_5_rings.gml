function monitor_grant_5_rings() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Give reward
	player_add_rings(5);
	mixer_play_effect(snd_ring_left);
	mixer_play_effect(snd_ring_right);
}

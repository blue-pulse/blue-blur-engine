function monitor_grant_10_rings() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Give reward
	player_add_rings(10);
	mixer_play_effect(snd_ring_super);
}

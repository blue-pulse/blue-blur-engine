function monitor_grant_stamina() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Give reward
	player_add_stamina(100);
	mixer_play_effect(snd_player_stamina_orb);
}

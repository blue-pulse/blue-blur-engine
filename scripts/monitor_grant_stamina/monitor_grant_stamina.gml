function monitor_grant_stamina() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Give reward
	player_add_stamina(100);
	audio_play_sfx(snd_player_stamina_orb);
}

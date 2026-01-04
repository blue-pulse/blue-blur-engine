function monitor_grant_random_rings() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Give reward
	var amount = choose(1, 5, 10, 30, 50);
	player_add_rings(amount);

	// SFX
	switch (amount) {
		// 1 ring
		case 1:
			audio_play_sfx(choose(snd_ring_left, snd_ring_right));
			break;
		
		// 5 rings
		case 5:
			audio_play_sfx(snd_ring_left);
			audio_play_sfx(snd_ring_right);
			break;
		
		// More than 10 rings
		case 10:
		case 30:
		case 50:
			audio_play_sfx(snd_ring_super);
			break;
	}
}

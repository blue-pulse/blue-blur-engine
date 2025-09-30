function player_get_rings(amount) {
	var total = objGameData.player_rings + amount;
	
	// Get lives
	if (total <= 999) {
		var change = (objGameData.player_rings mod 100) + amount;
		if (change >= 100) {
			player_get_lives(change div 100);
		}
	}
	
	// Get rings
	objGameData.player_rings = min(total, 999);
	
	// Sound
	audio_play_sfx(sfxRing);
}

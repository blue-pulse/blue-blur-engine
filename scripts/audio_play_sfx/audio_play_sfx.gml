function audio_play_sfx(sound, mode=0, loops=false) {	
	// Logic before playing anything
	switch (mode) {
		// Don't do anything
		case 0:
			break;
			
		// Ignore if already playing
		case 1:
			if (audio_is_playing(sound)) {
				return noone;
			}
			break;
			
		// Replace if is playing
		case 2:
			if (audio_is_playing(sound)) {
				audio_stop_sound(sound);
			}
			break;
	}
	
	// Play sound
	return audio_play_sound(sound, PRIORITY_SFX, loops, VOLUME_SFX);
}

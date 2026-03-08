function audio_play_sfx(sound, mode=0, loops=false) {	
	// Logic before playing anything
	switch (mode) {
		// Don't do anything
		case ESAU_MODES.OVERLAP:
			break;
			
		// Ignore if already playing
		case ESAU_MODES.SINGLE:
			if (audio_is_playing(sound)) {
				return noone;
			}
			break;
			
		// Swap if is playing
		case ESAU_MODES.SWAP:
			if (audio_is_playing(sound)) {
				audio_stop_sound(sound);
			}
			break;
	}
	
	// Play sound
	return audio_play_sound(sound, ESAU_PRIORITIES.SFX, loops, ESAU_VOLUME_SFX);
}

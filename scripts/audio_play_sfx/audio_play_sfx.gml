function audio_play_sfx(sound, mode=RAW, loops=false) {	
	// Logic before playing anything
	switch (mode) {
		// Don't do anything
		case RAW:
			break;
			
		// Skip if is playing
		case SKIP:
			if (audio_is_playing(sound)) {
				return noone;
			}
			break;
			
		// Replace if is playing
		case REPLACE:
			if (audio_is_playing(sound)) {
				audio_stop_sound(sound);
			}
			break;
	}
	
	// Play sound
	return audio_play_sound(sound, queue.sfx, loops);
}

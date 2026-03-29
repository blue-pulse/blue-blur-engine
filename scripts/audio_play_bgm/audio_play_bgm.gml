function audio_play_bgm(sound, loop_start=0, loop_end=0, position=0) {
	// Set the end of the loop as the end of the song
	if (loop_end == 0) {
		loop_end = audio_sound_length(sound);
	}
	
	// Configure the song
	audio_stop_sound(sound);
	audio_sound_loop_start(sound, loop_start);
	audio_sound_loop_end(sound, loop_end);
	
	// Play the song
	var song = audio_play_sound(sound, ESAU_PRIORITIES.BGM, true, ESAU_VOLUME_BGM, position);
	audio_sound_loop(song, true);
	return song;
}

function audio_play_sfx(sound, let_it_finish=false, loops=false) {
	if (let_it_finish and audio_is_playing(sound)) {
		return false;
	}
	audio_stop_sound(sound);
	return audio_play_sound(sound, queue.sfx, loops);
}

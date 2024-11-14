function audio_play_speech(speech) {
	var sound = is_array(speech) ? array_rand(speech) : speech;
	if (sound != noone) {
		audio_group_stop_all(grp_voices);
		return audio_play_sound(sound, queue.voices, false);
	}
	return false;
}

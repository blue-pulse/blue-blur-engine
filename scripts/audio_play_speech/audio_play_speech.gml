function audio_play_speech(sound) {
	var audio = is_array(sound) ? array_rand(sound) : sound;
	if (audio != noone) {
		audio_group_stop_all(GROUP_SPEECH);
		return audio_play_sound(audio, PRIORITY_SPEECH, false, VOLUME_SPEECH);
	}
	return false;
}

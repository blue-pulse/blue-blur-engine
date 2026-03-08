function audio_play_speech(sound) {
	var audio = is_array(sound) ? array_rand(sound) : sound;
	if (audio != noone) {
		audio_group_stop_all(ESAU_GROUP_VOICES);
		return audio_play_sound(audio, ESAU_PRIORITIES.VOICES, false, ESAU_VOLUME_VOICES);
	}
	return false;
}

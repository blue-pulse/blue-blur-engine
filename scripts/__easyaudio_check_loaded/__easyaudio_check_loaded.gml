function __easyaudio_check_loaded(_sound) {
	if (!audio_group_is_loaded(audio_sound_get_audio_group(_sound))) {
		__easyaudio_trace("[WARNING] " + audio_get_name(_sound) + " was played before its audio group finished loading, so it makes no sound! Wait until easyaudio_is_loaded returns true.");
	}
}

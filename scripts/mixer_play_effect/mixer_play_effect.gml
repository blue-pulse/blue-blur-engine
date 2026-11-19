function mixer_play_effect(_sound, _mode=mixer_modes.overlap, _is_looping=false) {
	// Translate the mode
	var _library_mode;
	switch (_mode) {
		case mixer_modes.single:
			_library_mode = EASYAUDIO_MODE.SINGLE;
			break;
		case mixer_modes.swap:
			_library_mode = EASYAUDIO_MODE.SWAP;
			break;
		default:
			_library_mode = EASYAUDIO_MODE.OVERLAP;
			break;
	}

	// Play sound
	return easyaudio_play_effect(_sound, _library_mode, _is_looping, global.sfx_volume);
}

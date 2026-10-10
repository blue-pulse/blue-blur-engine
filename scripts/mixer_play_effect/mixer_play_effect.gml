function mixer_play_effect(_sound, _mode=mixer_modes.overlap, _loop=false) {
	// Translate the mode
	var library_mode;
	switch (_mode) {
		case mixer_modes.single:
			library_mode = EASYAUDIO_MODE.SINGLE;
			break;
		case mixer_modes.swap:
			library_mode = EASYAUDIO_MODE.SWAP;
			break;
		default:
			library_mode = EASYAUDIO_MODE.OVERLAP;
			break;
	}

	// Play sound
	return easyaudio_play_effect(_sound, library_mode, _loop, global.sfx_volume);
}

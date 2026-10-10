function mixer_play_effect(_sound, _mode=mixer_modes.overlap, _loop=false) {
	// Translate the mode
	var library_mode;
	switch (_mode) {
		case mixer_modes.single:
			library_mode = ESAU_MODES.SINGLE;
			break;
		case mixer_modes.swap:
			library_mode = ESAU_MODES.SWAP;
			break;
		default:
			library_mode = ESAU_MODES.OVERLAP;
			break;
	}

	// Play sound
	return audio_play_sfx(_sound, library_mode, _loop);
}

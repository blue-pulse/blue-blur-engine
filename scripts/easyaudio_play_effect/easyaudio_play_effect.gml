/// Plays a sound effect, and unlike audio_play_sound it can skip the sound or restart it when it is already playing.
/// Returns the sound instance, or noone when the mode skipped the sound.
/// Registers a warning when the audio group of the sound has not finished loading.
/// @param {Asset.GMSound} sound Sound to play
/// @param {Enum.EASYAUDIO_MODE} [mode] OVERLAP always plays, SINGLE skips if already playing, SWAP stops the playing sound first
/// @param {Bool} [loop] Whether the sound loops
/// @param {Real} [volume] Gain of the sound
function easyaudio_play_effect(_sound, _mode=EASYAUDIO_MODE.OVERLAP, _loop=false, _volume=1) {
	// Logic before playing anything
	switch (_mode) {
		// Don't do anything
		case EASYAUDIO_MODE.OVERLAP:
			break;

		// Ignore if already playing
		case EASYAUDIO_MODE.SINGLE:
			if (audio_is_playing(_sound)) {
				return noone;
			}
			break;

		// Stop it first, which does nothing if it is not playing
		case EASYAUDIO_MODE.SWAP:
			audio_stop_sound(_sound);
			break;
	}

	// Play sound
	__easyaudio_check_loaded(_sound);
	return audio_play_sound(_sound, EASYAUDIO_PRIORITY_EFFECT, _loop, _volume);
}

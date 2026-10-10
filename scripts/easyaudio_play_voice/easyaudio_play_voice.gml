/// Stops the voice clips that are playing and plays another one, picking it at random when given an array.
/// Returns the sound instance, or false when there is nothing to play.
/// Registers a warning when the audio group of the clip has not finished loading.
/// @param {Asset.GMSound,Array<Asset.GMSound>} sound Voice clip, or array of voice clips to pick from
/// @param {Real} [volume] Gain of the clip
function easyaudio_play_voice(_sound, _volume=1) {
	static _system = __easyaudio_system();

	// Pick a clip
	var _audio = _sound;
	if (is_array(_sound)) {
		if (array_length(_sound) == 0) {
			return false;
		}
		_audio = _sound[irandom(array_length(_sound) - 1)];
	}

	// Play clip
	if (_audio != noone) {
		audio_group_stop_all(_system.__voice_group);
		__easyaudio_check_loaded(_audio);
		return audio_play_sound(_audio, EASYAUDIO_PRIORITY_VOICE, false, _volume);
	}
	return false;
}

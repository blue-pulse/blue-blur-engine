/// Plays a music track in a loop between two points, after stopping the instances of the same track.
/// The loop points are set on the asset, so they apply to every instance of it.
/// Returns the sound instance, and registers a warning when the audio group of the track has not finished loading.
/// @param {Asset.GMSound} sound Track to play
/// @param {Real} [loop_start] Second where the loop starts
/// @param {Real} [loop_end] Second where the loop ends, or 0 for the end of the track
/// @param {Real} [position] Second where the playback starts
/// @param {Real} [volume] Gain of the track
function easyaudio_play_music(_sound, _loop_start=0, _loop_end=0, _position=0, _volume=1) {
	// Set the end of the loop as the end of the song
	if (_loop_end == 0) {
		_loop_end = audio_sound_length(_sound);
	}

	// Configure the song
	audio_stop_sound(_sound);
	audio_sound_loop_start(_sound, _loop_start);
	audio_sound_loop_end(_sound, _loop_end);

	// Play the song
	__easyaudio_check_loaded(_sound);
	return audio_play_sound(_sound, EASYAUDIO_PRIORITY_MUSIC, true, _volume, _position);
}

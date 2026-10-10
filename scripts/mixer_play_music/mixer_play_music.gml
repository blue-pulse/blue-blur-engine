function mixer_play_music(_sound, _loop_start=0, _loop_end=0, _position=0) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return easyaudio_play_music(_sound, _loop_start, _loop_end, _position, global.bgm_volume);
}

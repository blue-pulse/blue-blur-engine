function audio_play_speech(sound) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	var audio = is_array(sound) ? array_rand(sound) : sound;
	if (audio != noone) {
		audio_group_stop_all(grp_voices);
		return audio_play_sound(audio, queue.voices, false);
	}
	return false;
}

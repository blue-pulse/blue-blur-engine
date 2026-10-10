function mixer_is_loaded() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return boolean
	return (
		audio_group_is_loaded(ESAU_GROUP_BGM) and
		audio_group_is_loaded(ESAU_GROUP_SFX) and
		audio_group_is_loaded(ESAU_GROUP_VOICES)
	);
}

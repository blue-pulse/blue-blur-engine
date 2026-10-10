/// Sets the three audio groups the library works with and starts loading them.
/// The loading is asynchronous, so use easyaudio_is_loaded to know when it has finished.
/// @param music_group Audio group of the music
/// @param effect_group Audio group of the sound effects
/// @param voice_group Audio group of the voice clips
function easyaudio_initialize(_music_group, _effect_group, _voice_group) {
	static _system = __easyaudio_system();
	_system.__music_group = _music_group;
	_system.__effect_group = _effect_group;
	_system.__voice_group = _voice_group;

	// Load groups in memory (Asynchronous)
	__easyaudio_trace("Loading audio groups in memory...");
	audio_group_load(_music_group);
	audio_group_load(_effect_group);
	audio_group_load(_voice_group);
}

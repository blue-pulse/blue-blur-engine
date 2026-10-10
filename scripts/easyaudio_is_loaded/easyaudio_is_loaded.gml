/// Returns whether the three audio groups have finished loading, which is false until easyaudio_initialize is called.
function easyaudio_is_loaded() {
	static _system = __easyaudio_system();
	return (
		_system.__music_group != undefined and
		audio_group_is_loaded(_system.__music_group) and
		audio_group_is_loaded(_system.__effect_group) and
		audio_group_is_loaded(_system.__voice_group)
	);
}

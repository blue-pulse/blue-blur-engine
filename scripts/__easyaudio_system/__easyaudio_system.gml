__easyaudio_system();
function __easyaudio_system() {
	static _system = undefined;
	if (_system != undefined) {
		return _system;
	}

	// Start package
	__easyaudio_trace("Welcome to EasyAudio by Blue Pulse! This is version " + EASYAUDIO_VERSION + ", " + EASYAUDIO_DATE);

	// Audio groups, which are set by easyaudio_initialize
	_system = {
		__music_group: undefined,
		__effect_group: undefined,
		__voice_group: undefined,
	};
	return _system;
}

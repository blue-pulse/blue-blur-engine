function __resnip_loop_repeat(_playback, _loop) {
	gml_pragma("forceinline");
	return (_playback.__repeats == undefined) ? _loop.repeats : (_playback.__repeats[$ _loop.__key] ?? _loop.repeats);
}

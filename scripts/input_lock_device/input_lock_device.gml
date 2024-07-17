function input_lock_device(duration) {
	global.allow_input = false;
	Core.alarm[0] = duration;
}

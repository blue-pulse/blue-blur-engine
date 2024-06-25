function input_get_device() {
	var device_type = input_source_using(INPUT_GAMEPAD) ? ("gamepad") : ("keyboard"); 
	return device_type;
}
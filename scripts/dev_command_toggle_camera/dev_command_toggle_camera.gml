function dev_command_toggle_camera(_player) {
	// Early exit
	if (!instance_exists(obj_camera)) {
		exit;
	}
	
	// Go back to the player
	if (camera_get_target() != _player) {
		camera_set_target(_player);
		exit;
	}
	
	// Focus a random entity
	var _count = instance_number(obj_actor);
	if (_count > 0) {
		camera_set_target(instance_find(obj_actor, irandom(_count - 1)));
	}
}

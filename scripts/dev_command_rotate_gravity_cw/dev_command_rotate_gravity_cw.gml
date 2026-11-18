function dev_command_rotate_gravity_cw(_player) {
	// Rotate the gravity clockwise
	with (_player) {
		player_set_gravity(gravity_direction + DEV_GRAVITY_STEP);
		if (instance_exists(obj_camera)) {
			camera_set_gravity(gravity_direction);
		}
	}
}

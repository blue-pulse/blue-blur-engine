function dev_command_rotate_gravity_ccw(_player) {
	// Rotate the gravity anticlockwise
	with (_player) {
		player_set_gravity(gravity_direction - DEV_GRAVITY_STEP);
		if (instance_exists(Camera)) {
			camera_set_gravity(gravity_direction);
		}
	}
}

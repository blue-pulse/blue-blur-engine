function camera_set_gravity(_player_direction) {
	// Turn the camera opposite to the gravity of the player
	obj_camera.gravity_direction = angle_wrap(360 - _player_direction);
}

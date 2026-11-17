function camera_set_gravity(_player_direction) {
	// The camera turns the opposite way to the gravity of the player
	Camera.gravity_direction = angle_wrap(360 - _player_direction);
}

function player_set_gravity(_direction) {
	// Rotate gravity
	gravity_direction = angle_wrap(_direction);
	
	// Reset the ground values when in the air
	if (!is_grounded) {
		player_set_ground(noone);
	}
}

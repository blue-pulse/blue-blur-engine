// Position
if (is_grounded) {
	if (is_spinning) {
		// When rolling
		handle_player_roll_movement();
		handle_player_wall_collision();
	} else {
		// When walking
		handle_player_ground_movement();
		handle_player_wall_collision();
	}
	// Is on a surface
	handle_player_position();
	handle_player_floor_collision();
} else {
	// Is in the air
	handle_player_air_movement();
	handle_player_position();
	handle_player_air_collision();
}
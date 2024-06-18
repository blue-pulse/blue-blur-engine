// Position
if (is_grounded) {
	if (is_spinning) {
		handle_player_roll_movement();
		handle_player_wall_collision();
	} else {
		handle_player_ground_movement();
		handle_player_wall_collision();
	}
	handle_player_position();
	handle_player_floor_collision();
} else {
	handle_player_position();
	handle_player_air_collision();
}
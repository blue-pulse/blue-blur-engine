if (is_grounded) {
	handle_player_position();
	handle_player_floor_collision();
} else {
	handle_player_position();
	handle_player_air_collision();
}
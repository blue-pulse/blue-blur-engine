function handle_player_position() {
	if (allow_movement) {
		pos_x += delta * horizontal_speed;
		pos_y += delta * vertical_speed;
	
		if (!is_grounded) {
			vertical_speed += delta * gravity_force;
		}
	}
}
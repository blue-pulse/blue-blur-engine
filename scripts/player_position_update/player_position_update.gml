function player_position_update() {
	// Position
	pos_x += horizontal_speed;
	pos_y += vertical_speed;
	
	// Vertical speed while airborne
	if (!is_grounded) {
		vertical_speed += gravity_force;
	}
}
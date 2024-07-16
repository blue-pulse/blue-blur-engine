function player_position_update() {
	// Position
	pos_x += delta(horizontal_speed);
	pos_y += delta(vertical_speed);
	
	// Vertical speed while airborne
	if (!is_grounded) {
		vertical_speed += delta(gravity_force);
	}
}
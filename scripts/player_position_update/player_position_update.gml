function player_position_update() {
	// Update position
	pos_x += hor_speed;
	pos_y += ver_speed;

	if (is_grounded) {
		// Reset air timer
		air_timer = 0;
	} else {
		// Increase vertical speed while airborne
		ver_speed += gravity_force;
		
		// Increase air timer
		air_timer++;
	}
}

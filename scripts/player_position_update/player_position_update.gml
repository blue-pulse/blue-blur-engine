function player_position_update() {
	// Remember last position
	prev_pos_x = pos_x;
	prev_pos_y = pos_y;
	
	// Update position
	pos_x += hor_speed;
	pos_y += ver_speed;
	
	// Increase vertical speed while airborne
	if (!is_grounded) {
		ver_speed += grv;
	}
	
}

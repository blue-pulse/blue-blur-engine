function player_in_room() {
	// Variables
	var pos_x_1 = 0;
	var pos_y_1 = 0;
	var pos_x_2 = 0;
	var pos_y_2 = 0;
	
	// Get position
	if (mask_direction mod 180 != 0) {
		pos_x_1 = x - ver_radius;
		pos_y_1 = y - hor_radius;
		pos_x_2 = x + ver_radius;
		pos_y_2 = y + hor_radius;
	} else {
		pos_x_1 = x - hor_radius;
		pos_y_1 = y - ver_radius;
		pos_x_2 = x + hor_radius;
		pos_y_2 = y + ver_radius;
	}
	
	// Check if already within bounds
	var player_in_bounds = rectangle_in_rectangle(pos_x_1, pos_y_1, pos_x_2, pos_y_2, ROOM_LEFT, ROOM_TOP, ROOM_RIGHT, ROOM_BOTTOM);
	if (player_in_bounds == 1) {
		return true;
	}

	// Move the player back within bounds according to their rotation
	switch (mask_direction) {
		// Down
		case 0:
			if (pos_x_1 < ROOM_LEFT) {
				x = ROOM_LEFT + hor_radius;
				if (hor_speed < 0) then hor_speed = 0;
			}
			
			if (pos_x_2 > ROOM_RIGHT) {
				x = ROOM_RIGHT - hor_radius;
				if (hor_speed > 0) then hor_speed = 0;
			}
			
			if (pos_y_2 + ver_radius < ROOM_TOP) {
				y = ROOM_TOP - ver_radius * 2;
			}
			
			// Out of bounds
			if (pos_y_1 > ROOM_BOTTOM) {
				y = ROOM_BOTTOM + ver_radius;
				return false;
			}
			break;
		
		// Right
		case 90:
			if (pos_y_1 < ROOM_TOP) {
				y = ROOM_TOP + hor_radius;
				if (hor_speed > 0) then hor_speed = 0;
			}
			
			if (pos_y_2 > ROOM_BOTTOM) {
				y = ROOM_BOTTOM - hor_radius;
				if (hor_speed < 0) then hor_speed = 0;
			}
			
			if (pos_x_2 + ver_radius < ROOM_LEFT) {
				x = ROOM_LEFT - ver_radius * 2;
			}
			
			// Out of bounds
			if (pos_x_1 > ROOM_RIGHT) {
				x = ROOM_RIGHT + ver_radius;
				return false;
			}
			break;
		
		// Up
		case 180:
			if (pos_x_1 < ROOM_LEFT) {
				x = ROOM_LEFT + hor_radius;
				if (hor_speed > 0) then hor_speed = 0;
			}
			
			if (pos_x_2 > ROOM_RIGHT) {
				x = ROOM_RIGHT - hor_radius;
				if (hor_speed < 0) then hor_speed = 0;
			}
			
			if (pos_y_1 - ver_radius > ROOM_BOTTOM) {
				y = ROOM_BOTTOM + ver_radius * 2;
			}
			
			// Out of bounds
			if (pos_y_2 < ROOM_TOP) {
				y = ROOM_TOP - ver_radius;
				return false;
			}
			break;
		
		// Left
		case 270:
			if (pos_y_1 < ROOM_TOP) {
				y = ROOM_TOP + hor_radius;
				if (hor_speed < 0) then hor_speed = 0;
			}
			
			if (pos_y_2 > ROOM_BOTTOM) {
				y = ROOM_BOTTOM - hor_radius;
				if (hor_speed > 0) then hor_speed = 0;
			}
			
			if (pos_x_1 - ver_radius > ROOM_RIGHT) {
				x = ROOM_RIGHT + ver_radius * 2;
			}
			
			// Out of bounds
			if (pos_x_2 < ROOM_LEFT) {
				x = ROOM_LEFT - ver_radius;
				return false;
			}
			break;
	}
	
	// Player is back within bounds
	return true;
}

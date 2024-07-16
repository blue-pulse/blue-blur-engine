function player_movement_air() {
	// Rotate angle back to 360 degrees
	if (angle < 180) {
		angle = max(angle - 2.8125, 0);
	} else {
		angle = min(angle + 2.8125, 360);
	}
	
	// Limit vertical speed if not jumping
	if (!is_jumping and (vertical_speed < -15.75)) {
		vertical_speed = -15.75;
	}
	
	if (!air_lock) {
		// Go left
		if (button_check("btn_left")) {
			if (horizontal_speed > 0) {
				// Decelerate
				horizontal_speed -= delta(air_accel);
			} else if (horizontal_speed > -top_speed) {
				// Accelerate
				horizontal_speed -= delta(air_accel);
				
				if (horizontal_speed <= -top_speed) {
					horizontal_speed = -top_speed;
				}
			}
			
			// Set facing direction
			facing = left;
		}
		
		// Go right
		if (button_check("btn_right")) {
			if (horizontal_speed < 0) {	
				// Decelerate
				horizontal_speed += delta(air_accel);
			} else if (horizontal_speed < top_speed) {
				// Accelerate
				horizontal_speed += delta(air_accel);
				
				if (horizontal_speed >= top_speed) {
					horizontal_speed = top_speed;
				}
			}
			
			// Set facing direction
			facing = right;
		}	
	}
	
	// Apply air drag
	if (!is_being_hurt and (vertical_speed < 0) and (vertical_speed > -4)) {
		horizontal_speed -= delta(floor(horizontal_speed / 0.125) / 256);
	}
}
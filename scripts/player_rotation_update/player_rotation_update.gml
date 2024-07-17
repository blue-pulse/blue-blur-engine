function player_rotation_update() {
	if (state != states.moving) {
		rotation = 360;
	} else {
		// Apply smooth rotation
		if (is_grounded) {
			// Determine target angle
			if ((angle >= 35.16) and (angle <= 324.84)) {
				var target_angle = angle;
				var rotation_step = (abs(ground_speed) / 16 + abs(ground_speed) / 32 - 2) * -1;
			} else {
				var target_angle = 360;
				var rotation_step = (abs(ground_speed) / 16 - 2) * -1;
			}
			
			// Set rotation
			var arctan_x = dcos(target_angle) + dcos(rotation) * rotation_step;
			var arctan_y = dsin(target_angle) + dsin(rotation) * rotation_step;
			rotation = darctan2(arctan_y, arctan_x);	
		} else {
			// Rotate back to 360
			if (rotation <= 0) {
				rotation += (360);
			}
			
			if (rotation < 180) {
				rotation = max(rotation - 2.8125, 0);
			} else {
				rotation = min(rotation + 2.8125, 360);
			}	
		}
	}
}
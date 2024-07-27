function player_rotation_update() {
	// Only rotate when moving
	if (state != states.moving) {
		rotation = 360;
	} else {
		// Apply smooth rotation
		if (is_grounded) {
			if (angle >= 35.16 and angle <= 324.84) {
				var target_angle = angle;
				var rotation_step = (abs(gnd_speed) / 16 + abs(gnd_speed) / 32 - 2) * -1
			}
			else {
				var target_angle = 360;
				var rotation_step = (abs(gnd_speed) / 16 - 2) * -1
			}
			rotation = darctan2(dsin(target_angle) + dsin(rotation) * rotation_step,
								dcos(target_angle) + dcos(rotation) * rotation_step);
		} else {
			// Rotate back to 360
			if (rotation <= 0) {
				rotation += 360;
			}
			if (rotation < 180) {
				rotation = max(rotation - 2.8125, 0);
			} else {
				rotation = min(rotation + 2.8125, 360);
			}
		}
	}
}

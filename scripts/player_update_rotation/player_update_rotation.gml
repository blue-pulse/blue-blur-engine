function player_update_rotation() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Grounded
	if (is_grounded) {
		var target_angle = (angle > 22.5 and angle < 337.5) ? (angle) : (0);
		var angle_diff = target_angle - rotation;
		var delta = abs(angle_diff);
		var cw_delta = abs(angle_diff + 360);
		var ccw_delta = abs(angle_diff - 360);
			
		if (delta > ccw_delta) {
			angle_diff -= 360;
		} else if (delta > cw_delta) {
			angle_diff += 360;
		}
		
		rotation += angle_diff / ((abs(hor_speed) >= 6) ? 2 : 4);
		rotation %= 360;
		if (rotation < 0) {
			rotation += 360;
		}
	}
	
	// Airbone
	else {
		rotation = angle_approach(rotation, gravity_direction, 4);
	}
}

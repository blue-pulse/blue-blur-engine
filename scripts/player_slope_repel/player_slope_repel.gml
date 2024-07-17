function player_slope_repel() {
	if (!stick_to_convex) {
		// Decrease timer every frame when grounded if non-zero
		if (ground_lock) {
			ground_lock -= (1);
		} else if ((angle >= 46.41) and (angle <= 315) and (abs(ground_speed) < 2.5)) {
			// Angle check here is different in comparison to collision mode checks
			is_grounded = false;
			ground_lock = 30;
			ground_speed = 0;
			
			// Change the state
			if (state == states.moving) {
				image_index = 0;
				state = states.falling;
			}
		}
	}
}

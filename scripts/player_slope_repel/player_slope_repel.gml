function player_slope_repel() {
	// Early exit
	if (stick_to_convex) {
		return;
	}

	// Decrease timer every frame when grounded if non-zero
	if (gnd_lock) {
		gnd_lock--;
	}

	// Check if we are on a steep slope and going slow
	else if (angle >= 46.41 and angle <= 315 and abs(gnd_speed) < 2.5) {
		// Angle check here is different in comparison to collision mode checks
		is_grounded = false;
		gnd_lock = 30;
		gnd_speed = 0;

		// Change the state
		if (state == states.moving) {
			image_index = 0;
			state = states.falling;
		}
	}
}

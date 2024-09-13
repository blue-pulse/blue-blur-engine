function player_slope_resist() {
	// Exit if on ceiling; angle check differs from collision mode.
	if (angle <= 225 and angle >= 136.41) {
		return;
	}

	// Set slope gravity
	slope_gravity = 0.125 * dsin(angle);

	// Apply it
	if (gnd_speed != 0) {
		gnd_speed -= slope_gravity;
	}
}
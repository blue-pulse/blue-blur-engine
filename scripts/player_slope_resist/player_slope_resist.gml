function player_slope_resist() {
	// Angle check here is different in comparison to collision mode checks
	var on_ceiling = (angle <= 225 and angle >= 136.41);
	if (!on_ceiling) {
		// Set slope gravity
		slope_gravity = 0.125 * dsin(angle);

		// Apply it
		if (gnd_speed != 0) {
			gnd_speed -= slope_gravity;
		}
	}
}

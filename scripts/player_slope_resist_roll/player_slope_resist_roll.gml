function player_slope_resist_roll() {
	// Exit if on ceiling; angle check differs from collision mode.
	if (angle <= 225 and angle >= 136.41) {
		return;
	}

	// Set slope gravity and then apply it
	if (sign(gnd_speed) != sign(dsin(angle))) {
		slope_gravity = 0.3125 * dsin(angle);
	} else {
		slope_gravity = 0.078125 * dsin(angle);
	}
	
	// Apply it
	gnd_speed -= slope_gravity;
}

function player_slope_resist_roll() {	
	// Angle check here is different in comparison to collision mode checks
	var on_ceiling = (angle <= 225) and (angle >= 136.41);
	if (!on_ceiling) {
		// Set slope gravity
		if (sign(ground_speed) != sign(dsin(angle))) {
			slope_gravity = 0.3125 * dsin(angle);
		} else {
			slope_gravity = 0.078125 * dsin(angle);
		}
		
		// Apply it
		ground_speed -= slope_gravity;
	}
}
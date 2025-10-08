function player_set_friction(force) {
	// Not moving or sliding down
	if (hor_speed == 0 and gnd_lock <= 0) {
		exit;
	}
	
	// Attached to a ceiling
	if (relative_angle > 135 and relative_angle < 225) {
		exit; 
	}
	
	// Moving on a shallow surface
	if (relative_angle < 22.5 or relative_angle > 337.5) {
		exit; 
	}
	
	// Apply
	hor_speed -= dsin(relative_angle) * force;
}

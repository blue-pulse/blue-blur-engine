function player_update_angle() {
	// Calculate rotational offset between angle and mask direction
	var diff = angle_difference(angle, mask_direction);
	
	// Abort if...
	if (abs(diff) <= 45 or abs(diff) >= 90) exit; // Offset is too steep or shallow
	if (collision_box(ver_radius * 2, hor_radius, (mask_direction mod 180 != 0), ground_id) == noone) exit; // Rotating would make the player fall
	
	// Calculate...
	var new_dir = angle_wrap(mask_direction + 90 * sign(diff)); // New mask direction
	var new_angle = player_get_angle(ground_id, new_dir); // Ground angle from new mask direction
	var new_diff = angle_difference(new_angle, mask_direction); // Rotational offset between new angle and mask direction
	
	// Abort if...
	if (sign(diff) != sign(new_diff)) exit; // Rotating the wrong way
	if (abs(new_diff) <= 45 or abs(new_diff) >= 90) exit; // New offset is too steep or shallow
	
	// Confirm rotation
	angle = new_angle;
	relative_angle = angle_wrap(angle - gravity_direction);
	mask_direction = new_dir;
}

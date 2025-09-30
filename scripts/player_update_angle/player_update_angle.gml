function player_update_angle() {
	// Variables
	var diff = angle_difference(angle, mask_direction);
	var abs_diff = abs(diff);
	
	// Exit if offset is too steep or shallow
	if (abs_diff <= 45 or abs_diff >= 90) {
		exit; 
	}
	
	// Exit if rotating would make the player fall
	var facing_dir = (mask_direction mod 180) != 0;
	if (!collision_box(ver_radius * 2, hor_radius, facing_dir, ground_id)) {
		exit; 
	}
	
	// Calculate new values
	var new_dir = angle_wrap(mask_direction + 90 * sign(diff));
	var new_angle = player_get_angle(ground_id, new_dir);
	var new_diff = angle_difference(new_angle, mask_direction);
	
	// Exit if rotating the wrong way
	if (sign(diff) != sign(new_diff)) {
		exit; 
	}
	
	// Exit if offset is too steep or shallow
	if (abs(new_diff) <= 45 or abs(new_diff) >= 90) {
		exit;
	}
	
	// Set values
	angle = new_angle;
	relative_angle = angle_wrap(angle - gravity_direction);
	mask_direction = new_dir;
}

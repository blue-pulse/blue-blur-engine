function player_set_ground(object) {
	// Reset ground and rotation values if no instance has been assigned
	if (!instance_exists(object)) {
		ground_id = noone;
		is_grounded = false;
		angle = gravity_direction;
		relative_angle = 0;
		mask_direction = angle;
		camera.ground_mode = false;
		exit;
	}
	
	// Calculate new ground angle
	var new_angle = player_get_angle(object, mask_direction);
	
	// Abort if terrain is too steep to map to
	if (is_grounded and abs(angle_difference(new_angle, angle)) > 45) {
		is_grounded = false;
		exit;
	}
	
	// Set new values
	ground_id = object;
	is_grounded = true;
	angle = new_angle;
	relative_angle = angle_wrap(angle - gravity_direction);
	
	// Align to ground
	var rotation = round(angle / 90) * 90;
	for (var i = 0; i < ver_radius * 2; ++i) {
		if (collision_box_vertical(hor_radius, i, rotation, ground_id)) {
			var height = (ver_radius - i) + 1;
			x -= dsin(rotation) * height;
			y -= dcos(rotation) * height;
			break;
		}
	}
}

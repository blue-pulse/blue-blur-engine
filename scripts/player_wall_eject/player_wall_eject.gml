function player_wall_eject(object) {
	// Variables
	var pos_x = floor(x);
	var pos_y = floor(y);
	var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	
	// Check if we're inside the wall
	if (collision_point(pos_x, pos_y, object, true, false)) {
		// Find and move to the closest side outside of collision
		for (var i = wall_radius; i < wall_radius * 2; ++i) {
			// Right of the wall
			if (!collision_ray_vertical(i, 0, mask_direction, object)) {
				x += cosine * (wall_radius + i);
				y -= sine * (wall_radius + i);
				return -1;
			}
			
			// Left of the wall
			else if (!collision_ray_vertical(-i, 0, mask_direction, object)) {
				x -= cosine * (wall_radius + i);
				y += sine * (wall_radius + i);
				return 1;
			}
		}
	}
	
	// Find the closest side within collision
	else {
		for (var i = wall_radius; i > -1; --i) {
			if (!collision_ray(i, 0, mask_direction, object)) {
				// Left of the wall
				if (collision_ray_vertical(i + 1, 0, mask_direction, object)) {
					x -= cosine * (wall_radius - i);
					y += sine * (wall_radius - i);
					return 1;
				}
				
				// Right of the wall
				else if (collision_ray_vertical(-(i + 1), 0, mask_direction, object)) {
					x += cosine * (wall_radius - i);
					y -= sine * (wall_radius - i);
					return -1;
				}
			}
		}
	}
	
	// Failure
	return 0;
}

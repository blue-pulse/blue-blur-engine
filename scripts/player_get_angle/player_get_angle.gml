function player_get_angle(object, fallback) {
	// Variables
	var obj_shape = noone;
	var obj_angle = 0;
	var obj_xscale = 1;
	var obj_yscale = 1;
	var obj_bbox_left = 0;
	var obj_bbox_right = 0;
	var obj_bbox_top = 0;
	var obj_bbox_bottom = 0;
	
	// Get the solid's collision and image data
	with (object) {
		obj_shape = shape;
		obj_angle = surface_angle;
		obj_xscale = sign(image_xscale);
		obj_yscale = sign(image_yscale);
		obj_bbox_left = bbox_left;
		obj_bbox_right = bbox_right + 1;
		obj_bbox_top = bbox_top;
		obj_bbox_bottom = bbox_bottom + 1;
	}
	
	// Custom shape
	if (obj_shape == SHP_CUSTOM) {
		// Initialize sensors
		var pos_x = floor(x);
		var pos_y = floor(y);
		var sine = dsin(fallback);
		var cosine = dcos(fallback);
		var left_sensor = false;
		var right_sensor = false;
		
		// Setup positions
		var pos_x_1 = pos_x - (cosine * hor_radius) + (sine * ver_radius);
		var pos_y_1 = pos_y + (sine * hor_radius) + (cosine * ver_radius);
		var pos_x_2 = pos_x + (cosine * hor_radius) + (sine * ver_radius);
		var pos_y_2 = pos_y - (sine * hor_radius) + (cosine * ver_radius);

		// Scan below feet
		repeat (ver_radius) {
			// Evaluate all solids
			for (var i = array_length(terrain_list) - 1; i > -1; --i) {
				// Get the current solid
				var instance = terrain_list[i];
				
				// Check if the left sensor found the solid
				if (not left_sensor and collision_point(pos_x_1, pos_y_1, instance, true, false)) {
					left_sensor = true;
				}
				
				// Check if the right sensor found the solid
				if (not right_sensor and collision_point(pos_x_2, pos_y_2, instance, true, false)) {
					right_sensor = true;
				}
				
				// Calculate the direction from left to right
				if (left_sensor and right_sensor) {
					return floor(point_direction(pos_x_1, pos_y_1, pos_x_2, pos_y_2));
				}
			}
			
			// Push the left sensor down
			if (!left_sensor) {
				pos_x_1 += sine;
				pos_y_1 += cosine;
			}
			
			// Push the right sensor down
			if (!right_sensor) {
				pos_x_2 += sine;
				pos_y_2 += cosine;
			}
		}
	}
	
	// Hard-coded shapes
	else if (not (obj_shape == SHP_RECTANGLE and obj_angle == -1)) {
		// Default if on a flat side of the solid
		if ((fallback == 0 and !obj_yscale)
			or (fallback == 90 and !obj_xscale)
			or (fallback == 180 and obj_yscale)
			or (fallback == 270 and obj_xscale)
			) {
			return fallback;
		}
		
		// Default if out of the solid's bounds
		if (fallback mod 180 != 0) {
			if ((!obj_yscale and y - hor_radius < obj_bbox_top) or (obj_yscale and y + hor_radius > obj_bbox_bottom)) {
				return fallback;
			}
		} else {
			if ((!obj_xscale and x - hor_radius < obj_bbox_left) or (obj_xscale and x + hor_radius > obj_bbox_right)) {
				return fallback;
			}
		}
		
		// If the solid's angle is hard-coded, return it
		if (obj_angle != -1) {
			return obj_angle;
		}
		
		// Determine calculation method
		if (obj_shape == SHP_RIGHT_TRIANGLE) {
			// Get triangle dimensions
			var pos_x_1 = obj_bbox_left;
			var pos_y_1 = obj_bbox_bottom;
			var pos_x_2 = obj_bbox_right;
			var pos_y_2 = obj_bbox_top;
			
			if (!obj_yscale) {
				pos_x_1 = obj_bbox_right;
				pos_x_2 = obj_bbox_left;
			}
			
			if (!obj_xscale) {
				pos_y_1 = obj_bbox_top;
				pos_y_2 = obj_bbox_bottom;
			}
			
			// Calculate the angle of the hypotenuse
			return floor(point_direction(pos_x_1, pos_y_1, pos_x_2, pos_y_2));
		} else {
			// Get ellipse center and player position
			var ellipse_x = (obj_shape == SHP_QUARTER_ELLIPSE xor obj_xscale) ? (obj_bbox_left) : (obj_bbox_right);
			var ellipse_y = (obj_shape == SHP_QUARTER_ELLIPSE xor obj_yscale) ? (obj_bbox_top) : (obj_bbox_bottom);
			var player_x = clamp(x, obj_bbox_left, obj_bbox_right);
			var player_y = clamp(y, obj_bbox_top, obj_bbox_bottom);
			
			// Calculate the direction from the player to the ellipse center
			var dir_to_center = 0;
			if (obj_shape == SHP_QUARTER_ELLIPSE) {
				dir_to_center = floor(point_direction(player_x, player_y, ellipse_x, ellipse_y));
			} else {
				dir_to_center = floor(point_direction(ellipse_x, ellipse_y, player_x, player_y));
			}
			
			// Return direction
			return (dir_to_center + 90) mod 360;
		}
	}
	
	// Failure
	return fallback;
}

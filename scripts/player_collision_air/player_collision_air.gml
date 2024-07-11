function player_collision_air() {
	if (allow_collision) {
		var horizontal_radius = default_radius_x + 1;

		// Define direction of our movement
		if (abs(horizontal_speed) >= abs(vertical_speed)) {
			var direction_movement = (horizontal_speed > 0) ? ("moving_right") : ("moving_left");
		} else {
			var direction_movement = (vertical_speed > 0) ? ("moving_down") : ("moving_up");
		}
	
		// Process collision
		switch (direction_movement) {
			case "moving_down":
				// Collide with left wall
				var found_wall = tile_find_h(pos_x - horizontal_radius, pos_y, false, plane)[0];
				if (found_wall < 0) {
					pos_x -= found_wall;
					horizontal_speed = 0;
				}
			
				// Collide with right wall
				var found_wall = tile_find_h(pos_x + horizontal_radius, pos_y, true, plane)[0];
				if (found_wall < 0) {
					pos_x += found_wall;
					horizontal_speed = 0;
				}
			
				// We have to remember both distances, so we do not use tile_find_2v here
				var found_floor_1 = tile_find_v(pos_x - radius_x, pos_y + radius_y, true, plane);
				var found_floor_2 = tile_find_v(pos_x + radius_x, pos_y + radius_y, true, plane);
				var clip_check = -(vertical_speed + 8);
				
				// Collide with floor
				if (found_floor_1[0] <= found_floor_2[0]) {
					var floor_distance = found_floor_1[0];
					var floor_angle	= found_floor_1[1];
				} else {
					var floor_distance = found_floor_2[0];
					var floor_angle = found_floor_2[1];
				}
				
				if (floor_distance < 0 and ((found_floor_1[0] >= clip_check) or (found_floor_2[0] >= clip_check))) {
					if (floor_angle >= 46.41 and floor_angle <= 315) {
						if (vertical_speed > 15.75) {
							vertical_speed = 15.75;
						}
						horizontal_speed = 0;
						ground_speed = (floor_angle < 180) ? (-vertical_speed) : (vertical_speed);
					} else if (floor_angle >= 23.91 and floor_angle <= 337.5) {
						ground_speed = (floor_angle < 180) ? (-vertical_speed / 2) : (vertical_speed / 2);
					} else {	
						vertical_speed = 0;
						ground_speed = horizontal_speed;	
					}
					
					// Adhere to the surface and land
					pos_y += floor_distance;
					angle = floor_angle;
					is_grounded = true;
				}
				break;	
			case "moving_up":
				// Collide with left wall
				var found_wall = tile_find_h(pos_x - horizontal_radius, pos_y, false, plane)[0];
				if (found_wall < 0) {
					pos_x -= found_wall;
					horizontal_speed = 0;
				}
			
				// Collide with right wall
				var found_wall = tile_find_h(pos_x + horizontal_radius, pos_y, true, plane)[0];
				if (found_wall < 0) {
					pos_x += found_wall;
					horizontal_speed = 0;
				}
			
				// Collide with ceiling
				var found_roof = tile_find_2v(pos_x - radius_x, pos_y - radius_y, pos_x + radius_x, pos_y - radius_y, false, noone, plane);
				if (found_roof[0] < 0) {	
					if (found_roof[1] >= 91.41 and found_roof[1] <= 136.41 
						or found_roof[1] >= 226.41 and found_roof[1] <= 268.59) {
						// Land on it if its angle steep enough
						angle = found_roof[1];
						ground_speed = (found_roof[1] < 180) ? (-vertical_speed) : (vertical_speed);
						is_grounded = true;
					} else {
						vertical_speed = 0;
					}				
					pos_y -= found_roof[0];
				}
				break;		
			case "moving_left":
				// Collide with left wall
				var found_wall = tile_find_h(pos_x - horizontal_radius, pos_y, false, plane)[0];
				if (found_wall < 0) {
					pos_x -= found_wall;
					ground_speed = vertical_speed;
					horizontal_speed = 0;
				} else {
					// Collide with ceiling
					var found_roof = tile_find_2v(pos_x - radius_x, pos_y - radius_y, pos_x + radius_x, pos_y - radius_y, false, noone, plane);
					if (found_roof[0] < 0) {	
						if (vertical_speed < 0) {
							vertical_speed = 0;
						}
						pos_y -= found_roof[0];
					} else if (vertical_speed > 0) {
						// Collide with floor
						var found_floor = tile_find_2v(pos_x - radius_x, pos_y + radius_y, pos_x + radius_x, pos_y + radius_y, true, noone, plane);
						if (found_floor[0] < 0) {
							pos_y += found_floor[0];
							angle = found_floor[1];
							ground_speed = horizontal_speed;
							vertical_speed = 0;
							is_grounded = true;
						}
					}
				}
				break;
			case "moving_right":
				// Collide with right wall
				var found_wall = tile_find_h(pos_x + horizontal_radius, pos_y, true, plane)[0];
				if (found_wall < 0) {
					pos_x += found_wall;
					ground_speed   = vertical_speed;
					horizontal_speed   = 0;	
				} else {
					// Collide with ceiling
					var found_roof = tile_find_2v(pos_x - radius_x, pos_y - radius_y, pos_x + radius_x, pos_y - radius_y, false, noone, plane);
					if (found_roof[0] < 0) {	
						if (vertical_speed < 0) {
							vertical_speed = 0;
						}
						pos_y -= found_roof[0];
					} else if (vertical_speed > 0) {
						// Collide with floor
						var found_floor = tile_find_2v(pos_x - radius_x, pos_y + radius_y, pos_x + radius_x, pos_y + radius_y, true, noone, plane);
						if (found_floor[0] < 0) {
							pos_y += found_floor[0];
							angle = found_floor[1];
							ground_speed = horizontal_speed
							vertical_speed = 0;
							is_grounded = true;
						}
					}
				}
				break;
		}
	
		// If landed, update floor mode
		if (is_grounded) {
			if ((angle <= 45) or (angle >= 315)) {
				collision_mode[0] = 0;
			} else if ((angle >= 46.41) and (angle <= 133.59)) {
				collision_mode[0] = 1;
			} else if ((angle >= 135) and (angle <= 225)) {
				collision_mode[0] = 2;
			} else if ((angle >= 226.41) and (angle <= 313.59)) {
				collision_mode[0] = 3;
			}
		
			// This will disable floor mode check for one frame, allowing us to land on the ceilings safely
			collision_mode[1] = true;
		}
	}
}
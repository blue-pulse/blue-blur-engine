function player_collision_wall() {
	var unsymmetric_check = (angle mod 90 != 0) and (angle >= 91.41) and (angle <= 270);
	if (allow_collision and !unsymmetric_check) {
		var vertical_offset = 8 * (angle == 360);
		var horizontal_radius = default_radius_x + 1;
	
		/* Get current angle quadrant, different from the one used for collision_mode to
		define the check direction. The game still uses collision_mode angle ranges to 
		decide to which side player should be pushed to. */
		if (angle <= 43.59 or angle >= 316.41) {
			var direction_check = 0;
		} else if (angle >= 45 and angle <= 135) {
			var direction_check = 1;
		} else if (angle >= 136.41 and angle <= 223.59) {
			var direction_check = 2;
		} else if (angle >= 225 and angle <= 315) {
			var direction_check = 3;
		}

		// Check for collisions, always one frame ahead
		if (gnd_speed < 0) {
			// Left wall collision
			switch (direction_check) {
				case 0:
					var found_wall = tile_find_h(pos_x + hor_speed - horizontal_radius, pos_y + ver_speed + vertical_offset, false, plane)[0];
					break;
				case 1:
					var found_wall = tile_find_v(pos_x + hor_speed, pos_y + ver_speed + horizontal_radius, true, plane)[0];
					break;
				case 2:
					var found_wall = tile_find_h(pos_x + hor_speed + horizontal_radius, pos_y + ver_speed, true, plane)[0];
					break;
				case 3:
					var found_wall = tile_find_v(pos_x + hor_speed, pos_y + ver_speed - horizontal_radius, false, plane)[0];
					break;
			}
		
			// Collide with it
			if (found_wall < 0) {
				switch (collision_mode[0]) {
					case 0:
						hor_speed -= found_wall;
						gnd_speed = 0;
					
						// Set pushing flag
						if (facing == LEFT and !is_rolling) {
							is_pushing = true;
						}
						break;
					case 1:
						ver_speed += found_wall;
						break;
					case 2:
						hor_speed += found_wall;
						gnd_speed = 0;
					
						// Set pushing flag
						if (facing == LEFT and !is_rolling) {
							is_pushing = true;
						}
						break;
					case 3:
						ver_speed -= found_wall;
						break;
				}
			}
		} else if (gnd_speed > 0) {
			// Right wall collision
			switch (direction_check) {
				case 0:
					var found_wall = tile_find_h(pos_x + hor_speed + horizontal_radius, pos_y + ver_speed + vertical_offset, true, plane)[0];
					break;
				case 1:
					var found_wall = tile_find_v(pos_x + hor_speed, pos_y + ver_speed - horizontal_radius, false, plane)[0];
					break;
				case 2:	
					var found_wall = tile_find_h(pos_x + hor_speed - horizontal_radius, pos_y + ver_speed, false, plane)[0];
					break;
				case 3:
					var found_wall = tile_find_v(pos_x + hor_speed, pos_y + ver_speed + horizontal_radius, true, plane)[0];
					break;
			}
			
			// Collide with it
			if (found_wall < 0) { 
				switch (collision_mode[0]) {
					case 0:
						hor_speed += found_wall;
						gnd_speed = 0;
					
						// Set pushing flag
						if (facing == RIGHT and !is_rolling) {
							is_pushing = true;
						}
						break;
					case 1:
						ver_speed -= found_wall;
						break;
					case 2:
						hor_speed -= found_wall;
						gnd_speed = 0;
				
						// Set pushing flag
						if (facing == RIGHT and !is_rolling) {
							is_pushing = true;
						}
						break;
					case 3:
						ver_speed += found_wall;
						break;
				}
			}
		}
	}
}

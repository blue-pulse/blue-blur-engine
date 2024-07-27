function player_collision_wall() {
	// Early exit
	if (!allow_collision) {
		return;
	}

	// Unsymmetric check here!
	if (angle >= 91.41 and angle <= 270) {
		if (angle mod 90 != 0) {
			return;
		}
	}

	// Define collision variables
	var ver_offset = 8 * (angle == 360);
	var hor_radius = df_radius_x + 1;

	// Get current angle quadrant for direction, while collision_mode uses angle ranges to determine push direction.
	if (angle <= 43.59 or angle >= 316.41) {
		var direction_check = 0;
	} else if (angle >= 45 and angle <= 135) {
		var direction_check = 1;
	} else if (angle >= 136.41 and angle <= 223.59) {
		var direction_check = 2;
	} else if (angle >= 225 and angle <= 315) {
		var direction_check = 3;
	}

	// Left wall collision
	if (gnd_speed < 0) {
		// Check for the wall to our left, frame ahead
		switch (direction_check) {
			case 0:
				var find_wall = tile_find_h(pos_x + hor_speed - hor_radius, pos_y + ver_speed + ver_offset, false, plane)[0];
				break;
			case 1:
				var find_wall = tile_find_v(pos_x + hor_speed, pos_y + ver_speed + hor_radius, true, plane)[0];
				break;
			case 2:
				var find_wall = tile_find_h(pos_x + hor_speed + hor_radius, pos_y + ver_speed, true, plane)[0];
				break;
			case 3:
				var find_wall = tile_find_v(pos_x + hor_speed, pos_y + ver_speed - hor_radius, false, plane)[0];
				break;
		}

		// Collide with it
		if (find_wall < 0) {
			switch (collision_mode[0]) {
				case 0:
					hor_speed -= find_wall;
					gnd_speed = 0;

					// Set pushing flag
					if (dir == LEFT and !is_rolling) {
						is_pushing = true;
					}
					break;
				case 1:
					ver_speed += find_wall;
					break;
				case 2:
					hor_speed += find_wall;
					gnd_speed = 0;

					// Set pushing flag
					if (dir == LEFT and !is_rolling) {
						is_pushing = true;
					}
					break;
				case 3:
					ver_speed -= find_wall;
					break;
			}
		}
	}

	// Right wall collision
	else if (gnd_speed > 0) {
		// Check for the wall to our right, frame ahead
		switch (direction_check) {
			case 0:
				var find_wall = tile_find_h(pos_x + hor_speed + hor_radius, pos_y + ver_speed + ver_offset, true, plane)[0];
				break;
			case 1:
				var find_wall = tile_find_v(pos_x + hor_speed, pos_y + ver_speed - hor_radius, false, plane)[0];
				break;
			case 2:
				var find_wall = tile_find_h(pos_x + hor_speed - hor_radius, pos_y + ver_speed, false, plane)[0];
				break;
			case 3:
				var find_wall = tile_find_v(pos_x + hor_speed, pos_y + ver_speed + hor_radius, true, plane)[0];
				break;
		}

		// Collide with it
		if (find_wall < 0) {
			switch (collision_mode[0]) {
				case 0:
					hor_speed += find_wall;
					gnd_speed = 0;

					// Set pushing flag
					if (dir == RIGHT and !is_rolling) {
						is_pushing = true;
					}
					break;
				case 1:
					ver_speed -= find_wall;
					break;
				case 2:
					hor_speed -= find_wall;
					gnd_speed = 0;

					// Set pushing flag
					if (dir == RIGHT and !is_rolling) {
						is_pushing = true;
					}
					break;
				case 3:
					ver_speed += find_wall;
					break;
			}
		}
	}
}

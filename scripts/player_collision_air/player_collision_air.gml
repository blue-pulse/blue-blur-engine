function player_collision_air() {
	// Early exit
	if (!allow_collision) {
		return;
	}

	// Define radius of our collision
	var hor_radius = big_radius_x + 1;

	// Define direction of our movement
	if (abs(hor_speed) >= abs(ver_speed)) {
		var move_direction = (hor_speed > 0) ? (RIGHT) : (LEFT);
	} else {
		var move_direction = (ver_speed > 0) ? (DOWN) : (UP);
	}

	// Process collision
	switch (move_direction) {
		case DOWN:
			// Collide with left wall
			var find_wall = tile_find_h(pos_x - hor_radius, pos_y, false, plane)[0];
			if (find_wall < 0) {
				pos_x -= find_wall;
				hor_speed = 0;
			}

			// Collide with right wall
			var find_wall = tile_find_h(pos_x + hor_radius, pos_y, true, plane)[0];
			if (find_wall < 0) {
				pos_x += find_wall;
				hor_speed = 0;
			}

			// Collide with floor. We have to remember both distances, so we do not use tile_find_2v here
			var find_floor_1 = tile_find_v(pos_x - radius_x, pos_y + radius_y, true, plane);
			var find_floor_2 = tile_find_v(pos_x + radius_x, pos_y + radius_y, true, plane);

			if (find_floor_1[0] <= find_floor_2[0]) {
				var dist = find_floor_1[0];
				var ang = find_floor_1[1];
			} else {
				var dist = find_floor_2[0];
				var ang = find_floor_2[1];
			}

			// Check if we are going to clip through the floor
			var clip_check = -(ver_speed + 8);

			if (dist < 0 and (find_floor_1[0] >= clip_check or find_floor_2[0] >= clip_check)) {
				if (ang >= 46.41 and ang <= 315) {
					if (ver_speed > 15.75) {
						ver_speed = 15.75;
					}
					hor_speed = 0;
					gnd_speed = (ang < 180) ? (-ver_speed) : (ver_speed);
				} else if (ang >= 23.91 and ang <= 337.5) {
					gnd_speed = (ang < 180) ? (-ver_speed / 2) : (ver_speed / 2);
				} else {
					ver_speed = 0;
					gnd_speed = hor_speed;
				}

				// Adhere to the surface and land
				pos_y += dist;
				angle = ang;
				is_grounded = true;
			}
			break;
		case UP:
			// Collide with left wall
			var find_wall = tile_find_h(pos_x - hor_radius, pos_y, false, plane)[0];
			if (find_wall < 0) {
				pos_x -= find_wall;
				hor_speed = 0;
			}

			// Collide with right wall
			var find_wall = tile_find_h(pos_x + hor_radius, pos_y, true, plane)[0];
			if (find_wall < 0) {
				pos_x += find_wall;
				hor_speed = 0;
			}

			// Collide with ceiling
			var find_roof = tile_find_2v(pos_x - radius_x, pos_y - radius_y, pos_x + radius_x, pos_y - radius_y, false, noone, plane);
			if (find_roof[0] < 0) {
				if (find_roof[1] >= 91.41 and find_roof[1] <= 136.41 or find_roof[1] >= 226.41 and find_roof[1] <= 268.59) {
					// Land on it if its angle steep enough
					angle = find_roof[1];
					gnd_speed = (find_roof[1] < 180) ? (-ver_speed) : (ver_speed);
					is_grounded = true;
				} else {
					ver_speed = 0;
				}
				pos_y -= find_roof[0];
			}
			break;
		case LEFT:
			// Collide with left wall
			var find_wall = tile_find_h(pos_x - hor_radius, pos_y, false, plane)[0];
			if (find_wall < 0) {
				pos_x -= find_wall;
				gnd_speed = ver_speed;
				hor_speed = 0;
			} else {
				// Collide with ceiling
				var find_roof = tile_find_2v(pos_x - radius_x, pos_y - radius_y, pos_x + radius_x, pos_y - radius_y, false, noone, plane);
				if (find_roof[0] < 0) {
					if (ver_speed < 0) {
						ver_speed = 0;
					}
					pos_y -= find_roof[0];
				} else if (ver_speed > 0) {
					// Collide with floor
					var find_floor = tile_find_2v(pos_x - radius_x, pos_y + radius_y, pos_x + radius_x, pos_y + radius_y, true, noone, plane);
					if (find_floor[0] < 0) {
						pos_y += find_floor[0];
						angle = find_floor[1];
						gnd_speed = hor_speed;
						ver_speed = 0;
						is_grounded = true;
					}
				}
			}
			break;
		case RIGHT:
			// Collide with right wall
			var find_wall = tile_find_h(pos_x + hor_radius, pos_y, true, plane)[0];
			if (find_wall < 0) {
				pos_x += find_wall;
				gnd_speed = ver_speed;
				hor_speed = 0;
			} else {
				// Collide with ceiling
				var find_roof = tile_find_2v(pos_x - radius_x, pos_y - radius_y, pos_x + radius_x, pos_y - radius_y, false, noone, plane);
				if (find_roof[0] < 0) {
					if (ver_speed < 0) {
						ver_speed = 0;
					}
					pos_y -= find_roof[0];
				} else if (ver_speed > 0) {
					// Collide with floor
					var find_floor = tile_find_2v(pos_x - radius_x, pos_y + radius_y, pos_x + radius_x, pos_y + radius_y, true, noone, plane);
					if (find_floor[0] < 0) {
						pos_y += find_floor[0];
						angle = find_floor[1];
						gnd_speed = hor_speed
						ver_speed = 0;
						is_grounded = true;
					}
				}
			}
			break;
	}

	// If landed, update floor mode if using the custom method
	if (is_grounded) {
		if (angle <= 45 or angle >= 315) {
			collision_mode[0] = 0;
		} else if (angle >= 46.41 and angle <= 133.59) {
			collision_mode[0] = 1;
		} else if (angle >= 135 and angle <= 225) {
			collision_mode[0] = 2;
		} else if (angle >= 226.41 and angle <= 313.59) {
			collision_mode[0] = 3;
		}

		// This will disable floor mode check for one frame, allowing us to land on the ceilings safely
		collision_mode[1] = true;
	}
}

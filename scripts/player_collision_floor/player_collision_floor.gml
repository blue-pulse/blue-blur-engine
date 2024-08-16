function player_collision_floor() {
	// Early exit
	if (!allow_collision or on_object) {
		return;
	}

	// Update collision mode
	if (!collision_mode[1]) {
		// If angle difference exceeds threshold, collision mode won't update.
		var angle_tolerance = 45;

		switch (collision_mode[0]) {
			// Floor mode
			case 0:
				// Switch to right wall mode
				var find_tile = tile_find_h(pos_x + radius_y - 2, pos_y + radius_x, true, plane);
				if (find_tile[0] < 0) {
					if (find_tile[1] - angle mod 360 < angle_tolerance) {
						collision_mode[0] = 1;
					}
				}

				// Switch to left wall mode
				var find_tile = tile_find_h(pos_x - radius_y + 2, pos_y + radius_x, false, plane);
				if (find_tile[0] < 0) {
					if (angle - find_tile[1] < angle_tolerance) {
						collision_mode[0] = 3;
					}
				}
				break;

			// Right wall mode
			case 1:
				// Switch to floor mode
				var find_tile = tile_find_v(pos_x + radius_x, pos_y + radius_y - 2, true, plane);
				if (find_tile[0] < 0) {
					if (angle - find_tile[1] mod 360 < angle_tolerance) {
						collision_mode[0] = 0;
					}
				}

				// Switch to ceiling mode
				var find_tile = tile_find_v(pos_x + radius_x, pos_y - radius_y + 2, false, plane);
				if (find_tile[0] < 0) {
					if (find_tile[1] - angle < angle_tolerance) {
						collision_mode[0] = 2;
					}
				}
				break;

			// Ceiling mode
			case 2:
				// Switch to right wall mode
				var find_tile = tile_find_h(pos_x + radius_y - 2, pos_y - radius_x, true, plane);
				if (find_tile[0] < 0) {
					if (angle - find_tile[1] < angle_tolerance) {
						collision_mode[0] = 1;
					}
				}

				// Switch to left wall mode
				var find_tile = tile_find_h(pos_x - radius_y + 2, pos_y - radius_x, false, plane);
				if (find_tile[0] < 0) {
					if (find_tile[1] - angle < angle_tolerance) {
						collision_mode[0] = 3;
					}
				}
				break;

			// Left wall mode
			case 3:
				// Switch to floor mode
				var find_tile = tile_find_v(pos_x - radius_x, pos_y + radius_y - 2, true, plane);
				if (find_tile[0] < 0) {
					if find_tile[1] - angle < angle_tolerance {
						collision_mode[0] = 0;
					}
				}

				// Switch to ceiling mode
				var find_tile = tile_find_v(pos_x - radius_x, pos_y - radius_y + 2, false, plane);
				if (find_tile[0] < 0) {
					if (angle - find_tile[1] < angle_tolerance) {
						collision_mode[0] = 2;
					}
				}
				break;
		}
	} else {
		// Reset landing flag
		collision_mode[1] = false;
	}


	// Perform collision based on current collision mode
	switch (collision_mode[0]) {
		// Floor mode
		case 0:
			// Get tile below us
			var find_floor = tile_find_2v(pos_x - radius_x, pos_y + radius_y, pos_x + radius_x, pos_y + radius_y, true, angle, plane);

			// Go airborne if surface is too far away from us
			if (!stick_to_convex) {
				var dist = min(4 + abs(floor(hor_speed)), 14);
				if (find_floor[0] > dist) {
					if (state == states.moving) {
						player_set_state(states.falling);
					}
					is_pushing = false;
					is_grounded = false;
					break;
				}
			}

			// Else collide
			if (find_floor[0] >= -14) {
				pos_y += find_floor[0];
				angle = find_floor[1];
			}
			break;

		// Right wall mode
		case 1:
			// Get tile to our right
			var find_floor = tile_find_2h(pos_x + radius_y, pos_y + radius_x, pos_x + radius_y, pos_y - radius_x, true, angle, plane);

			// Go airborne if surface is too far away from us
			if (!stick_to_convex) {
				var dist = min(4 + abs(floor(ver_speed)), 14);
				if (find_floor[0] > dist) {
					if (state == states.moving) {
						player_set_state(states.falling);
					}
					is_pushing = false;
					is_grounded = false;
					break;
				}
			}

			// Else collide
			if (find_floor[0] >= -14) {
				pos_x += find_floor[0];
				angle = find_floor[1];
			}
			break;

		// Ceiling mode
		case 2:
			// Get tile above us
			var find_floor = tile_find_2v(pos_x + radius_x, pos_y - radius_y, pos_x - radius_x, pos_y - radius_y, false, angle, plane);

			// Go airborne if surface is too far away from us
			if (!stick_to_convex) {
				var dist = min(4 + abs(floor(hor_speed)), 14);
				if (find_floor[0] > dist) {
					if (state == states.moving) {
						player_set_state(states.falling);
					}
					is_pushing = false;
					is_grounded = false;
					break;
				}
			}

			// Else collide
			if (find_floor[0] >= -14) {
				pos_y -= find_floor[0];
				angle = find_floor[1];
			}
			break;

		// Left wall mode
		case 3:
			// Get tile to our left
			var find_floor = tile_find_2h(pos_x - radius_y, pos_y - radius_x, pos_x - radius_y, pos_y + radius_x, false, angle, plane);

			// Go airborne if surface is too far away from us
			if (!stick_to_convex) {
				var dist = min(4 + abs(floor(ver_speed)), 14);
				if (find_floor[0] > dist) {
					if (state == states.moving) {
						player_set_state(states.falling);
					}
					is_pushing = false;
					is_grounded = false;
					break;
				}
			}

			// Else collide
			if (find_floor[0] >= -14) {
				pos_x -= find_floor[0];
				angle = find_floor[1];
			}
			break;
	}
}

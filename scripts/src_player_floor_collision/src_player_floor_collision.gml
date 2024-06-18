function handle_player_floor_collision() {
	if (allow_collision) {
		if (!collision_mode[1]) {
			var angle_tolerance = 45;
			
			switch (collision_mode[0]) {
				// Floor mode
				case 0:
					// Switch to right wall mode
					var x_1 = pos_x + radius_y - 2;
					var y_1 = pos_y + radius_x;
					var found_tile = tile_find_h(x_1, y_1, true, current_layer);
					if (found_tile[0] < 0) {
						if (found_tile[1] - angle mod 360 < angle_tolerance) {
							collision_mode[0] = 1;
						}
					}
					
					// Switch to left wall mode
					x_1 = pos_x - radius_y + 2;
					y_1 = pos_y + radius_x;
					found_tile = tile_find_h(x_1, y_1, false, current_layer);
					if (found_tile[0] < 0) {
						if (angle - found_tile[1] < angle_tolerance) {
							collision_mode[0] = 3;
						}
					}
					break;
				
				// Right wall mode
				case 1:	
					// Switch to floor mode
					var x_1 = pos_x + radius_x;
					var y_1 = pos_y + radius_y - 2;
					var found_tile = tile_find_v(x_1, y_1, true, current_layer);
					if (found_tile[0] < 0) {
						if (angle - found_tile[1] mod 360 < angle_tolerance) {
							collision_mode[0] = 0;
						}
					}
					
					// Switch to ceiling mode
					x_1 = pos_x + radius_x;
					y_1 = pos_y - radius_y + 2;
					found_tile = tile_find_v(x_1, y_1, false, current_layer);
					if (found_tile[0] < 0) {
						if (found_tile[1] - angle < angle_tolerance) {
							collision_mode[0] = 2;
						}
					}
					break;
				
				// Ceiling mode
				case 2:
					// Switch to right wall mode
					var x_1 = pos_x + radius_y - 2;
					var y_1 = pos_y - radius_x;
					var found_tile = tile_find_h(x_1, y_1, true, current_layer);
					if (found_tile[0] < 0) {
						if (angle - found_tile[1] < angle_tolerance) {
							collision_mode[0] = 1;
						}
					}
					
					// Switch to left wall mode
					x_1 = pos_x - radius_y + 2;
					y_1 = pos_y - radius_x;
					found_tile = tile_find_h(x_1, y_1, false, current_layer);
					if (found_tile[0] < 0) {
						if (found_tile[1] - angle < angle_tolerance) {
							collision_mode[0] = 3;
						}
					}
					break;
				
				// Left wall mode
				case 3:
					// Switch to floor mode
					var x_1 = pos_x - radius_x;
					var y_1 = pos_y + radius_y - 2;
					var found_tile = tile_find_v(x_1, y_1, true, current_layer);
					if (found_tile[0] < 0) {
						if (found_tile[1] - angle < angle_tolerance) {
							collision_mode[0] = 0;
						}
					}
					
					// Switch to ceiling mode
					x_1 = pos_x - radius_x;
					y_1 = pos_y - radius_y + 2;
					found_tile = tile_find_v(x_1, y_1, false, current_layer);
					if (found_tile[0] < 0) {
						if (angle - found_tile[1] < angle_tolerance) {
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
				var x_1 = pos_x - radius_x;
				var y_1 = pos_y + radius_y;
				var x_2 = pos_x + radius_x;
				var y_2 = pos_y + radius_y;
				var found_floor = tile_find_closest(x_1, y_1, x_2, y_2, true, angle, current_layer, tile_find_v);

				// Go airborne if surface is too far away from us
				if (!stick_to_convex) {
					var distance_to_floor = min(4 + abs(floor(horizontal_speed)), 14);
					if (found_floor[0] > distance_to_floor) {
						if (get_state() == moving) {
							show_debug_message("animation_reset");
						}
						is_pushing  = false;
						is_grounded = false;
						break;
					}		
				}
			
				// Else collide
				if (found_floor[0] >= -14) {
					pos_y += found_floor[0];
					angle = found_floor[1];	
				}
				break;
		
			// Right wall mode
			case 1:
				// Get tile to our right
				var x_1 = pos_x + radius_y;
				var y_1 = pos_y + radius_x;
				var x_2 = pos_x + radius_y;
				var y_2 = pos_y - radius_x;
				var found_floor = tile_find_closest(x_1, y_1, x_2, y_2, true, angle, current_layer, tile_find_h);
			
				// Go airborne if surface is too far away from us
				if (!stick_to_convex) {
					var distance_to_floor = min(4 + abs(floor(vertical_speed)), 14);
					if (found_floor[0] > distance_to_floor) {
						if (get_state() == moving) {
							show_debug_message("animation_reset");
						}
						is_pushing  = false;
						is_grounded = false;
						break;
					}	
				}
			
				// Else collide
				if (found_floor[0] >= -14) {
					pos_x += found_floor[0];
					angle = found_floor[1];	
				}
				break;
		
			// Ceiling mode
			case 2:	
				// Get tile above us
				var x_1 = pos_x + radius_x;
				var y_1 = pos_y - radius_y;
				var x_2 = pos_x - radius_x;
				var y_2 = pos_y - radius_y;
				var found_floor = tile_find_closest(x_1, y_1, x_2, y_2, false, angle, current_layer, tile_find_v);
			
				// Go airborne if surface is too far away from us
				if (!stick_to_convex) {
					var distance_to_floor = min(4 + abs(floor(horizontal_speed)), 14);
					if (found_floor[0] > distance_to_floor) {
						if (get_state() == moving) {
							show_debug_message("animation_reset");
						}
						is_pushing  = false;
						is_grounded = false;
						break;
					}
				}
			
				// Else collide
				if (found_floor[0] >= -14) {	
					pos_y -= found_floor[0];
					angle = found_floor[1];
				}
				break;
		
			// Left wall mode
			case 3:
				// Get tile to our left
				var x_1 = pos_x - radius_y;
				var y_1 = pos_y - radius_x;
				var x_2 = pos_x - radius_y;
				var y_2 = pos_y + radius_x;
				var found_floor = tile_find_closest(x_1, y_1, x_2, y_2, false, angle, current_layer, tile_find_h); 
			
				// Go airborne if surface is too far away from us
				if (!stick_to_convex) {
					var distance_to_floor = min(4 + abs(floor(vertical_speed)), 14);
					if (found_floor[0] > distance_to_floor) {
						if (get_state() == moving) {
							show_debug_message("animation_reset");
						}
						is_pushing  = false;
						is_grounded = false;
						break;
					}
				}
				
				// Else collide
			    if (found_floor[0] >= -14) {
					pos_x -= found_floor[0];
					angle = found_floor[1];
				}
				break;
		}
	}
}
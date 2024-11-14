function player_movement_ground() {
	// Early exit
	if (state == states.spindash) {
		return;
	}
	
	if (!gnd_lock) {
		// Variables
		var do_skid = false;
		
		// Handle movement to the left
		if (button_check("btn_left")) {
			// Decelerate
			if (gnd_speed > 0) {
				do_skid = true;
				gnd_speed -= decel;
				if (gnd_speed <= 0) {
					gnd_speed = -0.5;
				}
			}

			// Accelerate
			else {
				// Speed cap
				if (gnd_speed > -max_hor_speed) {
					gnd_speed = max(gnd_speed - accel, -max_hor_speed);
				}
				
				// Change direction
				if (dir != LEFT) {
					dir = LEFT;
					is_pushing = false;
					player_set_state(states.moving);
				}
				
				// Stop skidding
				if (state == states.skidding) {
					player_set_state(states.moving, false);
				}
			}
		} 
		
		// Handle movement to the right
		else if button_check("btn_right") {
			// Decelerate
			if (gnd_speed < 0) {
				do_skid = true;
				gnd_speed += decel;
				if (gnd_speed >= 0) {
					gnd_speed = 0.5;
				}
			}

			// Accelerate
			else {
				// Speed cap
				if (gnd_speed < max_hor_speed) {
					gnd_speed = min(gnd_speed + accel, max_hor_speed);
				}
				
				// Change direction
				if (dir != RIGHT) {
					dir = RIGHT;
					is_pushing = false;
					player_set_state(states.moving);
				}
				
				// Stop skidding
				if (state == states.skidding) {
					player_set_state(states.moving, false);
				}
			}
		}
		
		// Handle skid or movement animation
		var required_angle = (angle <= 45 or angle >= 316.41);
		if (!required_angle or gnd_speed != 0) {
			// Variables
			var material = player_find_material();
			
			// Continue moving
			if (state != states.skidding or state != states.pushing) {
				player_set_state(states.moving, false);
				player_play_footsteps(material);
			}
			
			// Start skidding
			if (required_angle and do_skid and abs(gnd_speed) >= 4 and state != states.skidding) {
				player_set_state(states.skidding, false);
				audio_play_sfx(snd_skid[material], true);
			}
		} else {
			// Idle actions
			if (button_check("btn_up")) {
				player_set_state(states.searching, false);
			} else if (button_check("btn_down")) {
				player_set_state(states.crouching, false);
			} else {
				player_set_state(states.idle, false);
			}
			
			// Reset flag
			is_pushing = false;
		}
		
		// Start pushing
		if (is_pushing) {
			player_set_state(states.pushing, false);
		}
	}

	// Apply friction
	if (abs(gnd_speed) > max_hor_speed or !button_check("btn_left") and !button_check("btn_right")) {
		if (gnd_speed > 0) {
			gnd_speed = max(gnd_speed - frict, 0);
		} else if (gnd_speed < 0) {
			gnd_speed = min(gnd_speed + frict, 0);
		}
	}

	// Convert ground inertia to speed
	hor_speed = gnd_speed * dcos(angle);
	ver_speed = gnd_speed * -dsin(angle);
	
	// Limit horizontal speed
	gnd_speed = clamp(gnd_speed, -max_abs_speed, max_abs_speed);
	hor_speed = clamp(hor_speed, -max_abs_speed, max_abs_speed);
}

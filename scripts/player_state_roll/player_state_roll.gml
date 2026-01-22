function player_state_roll(phase) {
	switch (phase) {
		// Start state
		case INIT:
	        is_rolling = true;
			audio_play_sfx(snd_player_roll, REPLACE);
	        break;
		
		// Run state
		case STEP:
			// Deceleration
			if (ground_lock <= 0) {
				// Left
				if (hor_speed > 0 and input_holded(vb_left)) {
					hor_speed -= roll_decel;
					if (hor_speed < 0) {
						hor_speed = 0;
					}
				}
				
				// Right
				if (hor_speed < 0 and input_holded(vb_right)) {
					hor_speed += roll_decel;
					if (hor_speed > 0) {
						hor_speed = 0;
					}
				}
				
				// Friction
				hor_speed -= sign(hor_speed) * min(abs(hor_speed), roll_frict);
			}
			
			// Variables
			var abs_speed = abs(hor_speed);
	
			// Update position
			if (!player_movement_ground()) {
				break;
			}
			
			// Falling
			if (!is_grounded) {
				player_set_state(player_state_airbone);
				break;
			}
			
			// Slide down steep surfaces
	        if (abs_speed < stumble_threshold) {
	            if (relative_angle >= 90 and relative_angle <= 270) {
					player_set_state(player_state_airbone);
					break;
	            } else if (relative_angle >= 45 and relative_angle <= 315) {
					ground_lock = stumble_timer;
				}
	        }
			
			// Slope friction
			if (sign(hor_speed) == sign(dsin(relative_angle))) {
				player_set_friction(slope_frict_up);
			} else {
				player_set_friction(slope_frict_down);
			}
			
			// Jumping
	        if (input_pressed(vb_a)) {
				player_set_state(player_state_jump);
				break;
			}
			
			// Unroll
			if (abs_speed < unroll_threshold) {
				player_set_state(player_state_run);
				break;
			}
			
			// Animate
			if (abs_speed > 5) {
				var anim_speed = map(abs_speed, 5, 12, 1.25, 2.25);
				animation_play(anim_roll_fast, anim_speed);
			} else {
				var anim_speed = clamp(abs_speed, 1, 1.5);
				animation_play(anim_roll_slow, anim_speed);
			}
			break;
		
		// Stop state
		case STOP:
			rotation = gravity_direction;
			break;
	}
}

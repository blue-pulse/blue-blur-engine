function player_state_run(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Update variables
	        is_rolling = false;
			player_reset_combo();
	        break;
		
		// Run state
		case STEP:
			// Get input direction
			var input_dir = input_opposing(vb_left, vb_right);

			// Handle ground movement if not sliding down
			if (gnd_lock <= 0) {
				if (input_dir != 0) {
					// Moving in the opposite direction
					if (hor_speed != 0 and sign(hor_speed) != input_dir) {
						// Turn around
						if (sign(image_xscale) == -input_dir and abs(hor_speed) <= skid_threshold) {
							player_set_state(player_state_turn);
							exit;
						}
				
						// Skidding
						if (state != player_state_skid and abs(hor_speed) > skid_threshold and mask_direction == gravity_direction) {
							audio_play_sfx(snd_player_skid);
							player_set_state(player_state_skid);
							exit;
						}
						
						// Decelerate and reverse direction
						hor_speed += decel * input_dir;
						if (sign(hor_speed) == input_dir) {
							hor_speed = decel * input_dir;
						}
					}
					
					// Accelerate
					else {
						image_xscale = input_dir;
						if (abs(hor_speed) < speed_cap) {
							hor_speed += accel * input_dir;
							if (abs(hor_speed) > speed_cap) {
								hor_speed = speed_cap * input_dir;
							}
						}
					}
				}
				
				// Friction
				else {
					hor_speed -= min(abs(hor_speed), frict) * sign(hor_speed);
				}
			}
			
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not is_grounded) return player_is_falling(INIT);
			
			// Fall / slide down steep surfaces
	        if (abs(hor_speed) < slide_threshold)
	        {
	            if (relative_angle >= 90 and relative_angle <= 270)
	            {
	                return player_is_falling(INIT);
	            }
	            else if (relative_angle >= 45 and relative_angle <= 315)
				{
					gnd_lock = slide_timer;
				}
	        }
			
			// Slope friction
			player_set_friction(slope_frict);
			
	        // Standing
			if (hor_speed == 0 and input_dir == 0)
	        {
	            player_set_state(player_state_idle);
				exit;
	        }
			
			// Jumping
	        if (input_pressed(vb_a)) return player_is_falling(-2);
			
			// Rolling
			if (input_holded(vb_down) and input_dir == 0 and abs(hor_speed) >= roll_threshold)
			{
				//audio_play_sfx(sfxRoll);
				return player_is_rolling(INIT);
			}
			
			// Animate
			if (not ((animation_index == "push" and image_xscale == input_dir) or
					(animation_index == "brake" and timeline_position < 24 and mask_direction == gravity_direction and image_xscale != input_dir)))
	        {
				var velocity = (abs(hor_speed) div 1);
				if (velocity < 10)
				{
					if (velocity < 6) {
						player_set_animation(anim_walk);
					} else {
						player_set_animation(anim_run);
					}
				}
				else {
					player_set_animation(anim_sprint);
				}
	            timeline_speed = 1 / max(8 - velocity, 1);
	        }
	        image_angle = angle;
			
			// Brake dust
			if (animation_index == "brake" and global.ticks mod 4 == 0)
			{
				var height = ver_radius - 6;
				var ox = x + dsin(angle) * height;
				var oy = y + dcos(angle) * height;
				part_particles_create(global.particles, ox, oy, global.brake_dust, 1);
			}
			break;
		
		// Stop state
		case STOP:
			gnd_lock = 0;
			break;
	}
}
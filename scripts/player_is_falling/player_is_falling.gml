function player_is_falling(phase)
{
	switch (phase)
	{
		case -2:
		{
			// Set state and flags
	        state = player_is_falling;
	        is_rolling = true;
	        is_jumping = true;
	        jump_action = true;

	        // Movement
			var sine = dsin(relative_angle);
			var cosine = dcos(relative_angle);
			ver_speed = (-sine * hor_speed) - (cosine * jump_height);
	        hor_speed = (cosine * hor_speed) - (sine * jump_height);

	        // Set air state
			player_set_ground(noone);
			
			// Animate
			animation_index = "spin";
	        timeline_speed = 1 / max(5 - (abs(hor_speed) div 1), 1);
	        image_angle = gravity_direction;
			
			// Sound
			//audio_play_sfx(sfxJump);
			break;
		}
		case INIT:
		{
			// Set state and flags
			state = player_is_falling;
			
			// Movement
			ver_speed = -dsin(relative_angle) * hor_speed;
			hor_speed = dcos(relative_angle) * hor_speed;
			
			// Set air state
			player_set_ground(noone);
			
			// Animate
			if (not is_rolling) animation_index = "fall";
			break;
		}
		default:
		{
			// Handle aerial acceleration
	        if (input_check(vb_left))
	        {
	            image_xscale = -1;
	            if (hor_speed > -speed_cap)
	            {
	                hor_speed = max(hor_speed - air_acceleration, -speed_cap);
	            }
	        }
	        if (input_check(vb_right))
	        {
	            image_xscale = 1;
	            if (hor_speed < speed_cap)
	            {
	                hor_speed = min(hor_speed + air_acceleration, speed_cap);
	            }
	        }
			
	        // Update position
			if (not player_movement_air()) exit;
			
	        // Landing
	        if (is_grounded)
	        {
				if (hor_speed == 0) {
					player_set_state(player_state_idle);
				} else {
					player_is_running(-1);
				}
				exit;
	        }
			
			// Variable jump height
	        if (is_jumping and not input_check(vb_a) and ver_speed < -jump_release)
	        {
	            ver_speed = -jump_release;
	        }
			
	        // Air friction
	        if (ver_speed < 0 and ver_speed > -4 and abs(hor_speed) > air_threshold)
	        {
				hor_speed *= air_frict;
	        }
			
	        // Gravity
			if (ver_speed < gravity_cap) ver_speed = min(ver_speed + gravity_force, gravity_cap);
			
			// Homing actions
			if (is_rolling)
			{
				// Reticle creation/destruction
				if (not instance_exists(obj_reticle))
				{
					if (jump_action)
					{
						// Record targets (higher priority ones should be added at the end of the list)
						var target_list = [instance_nearest(x, y, objMonitor), instance_nearest(x, y, objBadnik)];
						
						// Evaluate all targets
						for (var n = array_length(target_list) - 1; n > -1; --n)
						{
							// Get the current target; lock on to it if possible
							var inst = target_list[n];
							if (inst != noone and player_can_lock_on(inst))
							{
								with (instance_create_depth(inst.x, inst.y, depth - 1, obj_reticle))
								{
									target = inst;
									owner = other.id;
								}
								break;
							}
						}
					}
				}
				else if (not player_can_lock_on(obj_reticle.target))
				{
					instance_destroy(obj_reticle);
				}
				
				// Perform a homing action
				if (input_pressed(vb_a) and jump_action)
				{
					// Burst effect and sound
					part_particles_create(global.particles, x, y, global.homing_burst, 1);
					//audio_play_sfx(sfxSpinDash);
					
					// Homing attack if the reticle is present; dash otherwise
					if (instance_exists(obj_reticle))
					{
						return player_is_homing(-1);
					}
					else
					{
						hor_speed = 8 * image_xscale;
						ver_speed = 0;
						jump_action = false;
					}
				}
			}
			else if (input_pressed(vb_a)) // Curl up
			{
				// Set flags
				is_rolling = true;
				jump_action = true;
				
				// Animate
				animation_index = "spin";
		        timeline_speed = 1 / max(5 - (abs(hor_speed) div 1), 1);
		        image_angle = gravity_direction;
			}
			
			// Animate
			if (animation_index == "rise" and ver_speed >= 0)
			{
				animation_index = "fall";
			}
			if (image_angle != angle and not is_rolling)
	        {
	            image_angle = angle_wrap(image_angle + 2.8125 * sign(angle_difference(angle, image_angle)));
	        }
		}
	}
}
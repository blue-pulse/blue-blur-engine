/// @description The player's falling state.
/// @param {Real} phase The state's current step (-2 for is_jumping, -1 for starting, 0 for main).
/// @returns {Function} The state that the player will change to given the applicable conditions.
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
		case -1:
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
				return (hor_speed != 0) ? player_is_running(-1) : player_is_standing(-1);
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
				if (not instance_exists(objReticle))
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
								with (instance_create_depth(inst.x, inst.y, depth - 1, objReticle))
								{
									target_id = inst;
									player_id = other.id;
								}
								break;
							}
						}
					}
				}
				else if (not player_can_lock_on(objReticle.target_id))
				{
					instance_destroy(objReticle);
				}
				
				// Perform a homing action
				if (input_pressed(vb_a) and jump_action)
				{
					// Burst effect and sound
					part_particles_create(global.particles, x, y, global.homing_burst, 1);
					//audio_play_sfx(sfxSpinDash);
					
					// Homing attack if the reticle is present; dash otherwise
					if (instance_exists(objReticle))
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

/// @description The player's homing attack state.
/// @param {Real} phase The state's current step (-1 for starting, 0 for main).
/// @returns {Function} The player's falling state.
function player_is_homing(phase)
{
	switch (phase)
	{
		case -1:
		{
			// Set state and flags
			state = player_is_homing;
			is_jumping = false;
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_air()) exit;
			
			// Fall if the reticle can no longer be locked on to
			if (not player_can_lock_on(objReticle.target_id))
			{
				is_jumping = true;
				jump_action = false;
				instance_destroy(objReticle);
				return player_is_falling(-1);
			}
			
			// Move towards the reticle
			var homing_speed = 12;
			var dir = point_direction(x, y, objReticle.x, objReticle.y) - mask_direction;
			hor_speed = lengthdir_x(homing_speed, dir);
			ver_speed = lengthdir_y(homing_speed, dir);
		}
	}
}

/// @description The player's hurt state.
/// @param {Real} phase The state's current step (-1 for starting, 0 for main).
/// @returns {Function} The player's standing state.
function player_is_hurt(phase)
{
	switch (phase)
	{
		case -1:
		{
			// Set state and flags
			state = player_is_hurt;
	        is_rolling = false;
			
			// Set air state
			player_set_ground(noone);
			
			// Animate
			animation_index = "hurt";
			timeline_speed = 1;
			image_angle = gravity_direction;
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_air())
			{
				recovery_timer = 120;
				exit;
			}
			
			// Landing
			if (is_grounded)
			{
				// Stop moving
				hor_speed = 0;
				
				// Gain temporary invulnerability
				recovery_timer = 120;
				
				// Stand
				return player_is_standing(-1);
			}
			
			// Gravity
			if (ver_speed < gravity_cap) ver_speed = min(ver_speed + recoil_gravity, gravity_cap);
		}
	}
}

/// @description The player's debugging state.
/// @param {Real} phase The state's current step (-1 for starting, 0 for main).
function player_is_debugging(phase)
{
	switch (phase)
	{
		case -1:
		{
			// Set state and flags
			state = player_is_debugging;
			is_rolling = false;
			
			// Movement
			hor_speed = 0;
			ver_speed = 0;
			
			// Set air state
			player_set_ground(noone);
			break;
		}
		default:
		{
			// Fly around, whilst staying within bounds
			x += (input_check(vb_right) - input_check(vb_left)) * 8;
			y += (input_check(vb_down) - input_check(vb_up)) * 8;
			player_in_view();
		}
	}
}
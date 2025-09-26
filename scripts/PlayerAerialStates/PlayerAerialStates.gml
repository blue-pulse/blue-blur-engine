/// @description The player's falling state.
/// @param {Real} phase The state's current step (-2 for jumping, -1 for starting, 0 for main).
/// @returns {Function} The state that the player will change to given the applicable conditions.
function player_is_falling(phase)
{
	switch (phase)
	{
		case -2:
		{
			// Set state and flags
	        state = player_is_falling;
	        spinning = true;
	        jumping = true;
	        jump_action = true;

	        // Movement
			var sine = dsin(relative_angle);
			var cosine = dcos(relative_angle);
			y_speed = (-sine * x_speed) - (cosine * jump_height);
	        x_speed = (cosine * x_speed) - (sine * jump_height);

	        // Set air state
			player_set_ground(noone);
			
			// Animate
			animation_index = "spin";
	        timeline_speed = 1 / max(5 - (abs(x_speed) div 1), 1);
	        image_angle = gravity_direction;
			
			// Sound
			audio_play_sfx(sfxJump);
			break;
		}
		case -1:
		{
			// Set state and flags
			state = player_is_falling;
			
			// Movement
			y_speed = -dsin(relative_angle) * x_speed;
			x_speed = dcos(relative_angle) * x_speed;
			
			// Set air state
			player_set_ground(noone);
			
			// Animate
			if (not spinning) animation_index = "fall";
			break;
		}
		default:
		{
			// Handle aerial acceleration
	        if (input_left)
	        {
	            image_xscale = -1;
	            if (x_speed > -speed_cap)
	            {
	                x_speed = max(x_speed - air_acceleration, -speed_cap);
	            }
	        }
	        if (input_right)
	        {
	            image_xscale = 1;
	            if (x_speed < speed_cap)
	            {
	                x_speed = min(x_speed + air_acceleration, speed_cap);
	            }
	        }
			
	        // Update position
			if (not player_movement_air()) exit;
			
	        // Landing
	        if (on_ground)
	        {
				return (x_speed != 0) ? player_is_running(-1) : player_is_standing(-1);
	        }
			
			// Variable jump height
	        if (jumping and not input_action and y_speed < -jump_release)
	        {
	            y_speed = -jump_release;
	        }
			
	        // Air friction
	        if (y_speed < 0 and y_speed > -4 and abs(x_speed) > air_friction_threshold)
	        {
				x_speed *= air_friction;
	        }
			
	        // Gravity
			if (y_speed < gravity_cap) y_speed = min(y_speed + gravity_force, gravity_cap);
			
			// Homing actions
			if (spinning)
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
				if (input_action_pressed and jump_action)
				{
					// Burst effect and sound
					part_particles_create(objResources.particles, x, y, objResources.homing_burst, 1);
					audio_play_sfx(sfxSpinDash);
					
					// Homing attack if the reticle is present; dash otherwise
					if (instance_exists(objReticle))
					{
						return player_is_homing(-1);
					}
					else
					{
						x_speed = 8 * image_xscale;
						y_speed = 0;
						jump_action = false;
					}
				}
			}
			else if (input_action_pressed) // Curl up
			{
				// Set flags
				spinning = true;
				jump_action = true;
				
				// Animate
				animation_index = "spin";
		        timeline_speed = 1 / max(5 - (abs(x_speed) div 1), 1);
		        image_angle = gravity_direction;
			}
			
			// Animate
			if (animation_index == "rise" and y_speed >= 0)
			{
				animation_index = "fall";
			}
			if (image_angle != angle and not spinning)
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
			jumping = false;
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_air()) exit;
			
			// Fall if the reticle can no longer be locked on to
			if (not player_can_lock_on(objReticle.target_id))
			{
				jumping = true;
				jump_action = false;
				instance_destroy(objReticle);
				return player_is_falling(-1);
			}
			
			// Move towards the reticle
			var homing_speed = 12;
			var dir = point_direction(x, y, objReticle.x, objReticle.y) - mask_direction;
			x_speed = lengthdir_x(homing_speed, dir);
			y_speed = lengthdir_y(homing_speed, dir);
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
	        spinning = false;
			
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
				recovery_time = 120;
				exit;
			}
			
			// Landing
			if (on_ground)
			{
				// Stop moving
				x_speed = 0;
				
				// Gain temporary invulnerability
				recovery_time = 120;
				
				// Stand
				return player_is_standing(-1);
			}
			
			// Gravity
			if (y_speed < gravity_cap) y_speed = min(y_speed + recoil_gravity, gravity_cap);
		}
	}
}

/// @description The player's death state.
/// @param {Real} phase The state's current step (-1 for starting, 0 for main).
function player_is_dead(phase)
{
	switch (phase)
	{
		case -1:
		{
			// Set state and flags
			state = player_is_dead;
			spinning = false;
			objStage.timer_enabled = false;
			
			// Movement
			y_speed = -7;
			
			// Remove effects
			instance_destroy(invincibility_effect);
			
			// Animate
			animation_index = "dead";
			image_angle = gravity_direction;
			
			// Sound
			audio_play_sfx(sfxDeath);
			break;
		}
		default:
		{
			// Update position
			x += dsin(gravity_direction) * y_speed;
			y += dcos(gravity_direction) * y_speed;
			
			// Gravity
			if (y_speed < gravity_cap) y_speed = min(y_speed + gravity_force, gravity_cap);
			
			// Finish
			if (not in_view(id, 24) and y_speed > 3)
			{
				// Deduct lives; is the game over?
				if (--objGameData.player_lives <= 0 or objStage.time_over)
				{
					instance_create_layer(0, 0, "Overlays", objGameOver);
				}
				else objStage.reset_time = 60; // If not, restart
				instance_destroy();
			}
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
			spinning = false;
			
			// Movement
			x_speed = 0;
			y_speed = 0;
			
			// Set air state
			player_set_ground(noone);
			break;
		}
		default:
		{
			// Fly around, whilst staying within bounds
			x += (input_right - input_left) * 8;
			y += (input_down - input_up) * 8;
			player_in_camera_bounds();
		}
	}
}
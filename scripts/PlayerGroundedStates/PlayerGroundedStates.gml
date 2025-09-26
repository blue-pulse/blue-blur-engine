/// @description The player's transitionary state until the stage has begun.
/// @returns {Function} The player's standing state.
function player_is_starting()
{
	if (objStage.started)
	{
		timeline_running = true;
		camera.ground_mode = true;
		return player_is_standing(-1);
	}
}

/// @description The player's standing state.
/// @param {Real} phase The state's current step (-1 for starting, 0 for main).
/// @returns {Function} The state that the player will change to given the applicable conditions.
function player_is_standing(phase)
{
	switch (phase)
	{
		case -1:
		{
			// Set state and flags
			state = player_is_standing;
	        spinning = false;
			
			// Reset score combo
			if (invincibility_time <= 0) score_combo = 0;
			
			// Find nearest cliff edge
			player_find_cliff();
			
			// Animate
			animation_index = (cliff_sign != 0) ? "teeter" : "idle";
			timeline_speed = 1;
			image_angle = gravity_direction;
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not on_ground) return player_is_falling(-1);
			
			// Fall / slide down steep surfaces
	        if (relative_angle >= 90 and relative_angle <= 270)
	        {
	            return player_is_falling(-1);
	        }
			else if (relative_angle >= 45 and relative_angle <= 315)
			{
				control_lock_time = default_slide_lock;
				return player_is_running(-1);
			}

	        // Running
	        if (input_left or input_right or x_speed != 0)
	        {
	            return player_is_running(-1);
	        }
			
			// Jumping
	        if (input_action_pressed) return player_is_falling(-2);
			
			// Looking/crouching
			if (cliff_sign == 0)
			{
				if (input_up) return player_is_looking(-1);
				if (input_down) return player_is_crouching(-1);
			}
		}
	}
}

/// @description The player's running state.
/// @param {Real} phase The state's current step (-1 for starting, 0 for main).
/// @returns {Function} The state that the player will change to given the applicable conditions.
function player_is_running(phase)
{
	switch (phase)
	{
		case -1:
		{
			// Set state and flags
	        state = player_is_running;
	        spinning = false;
			
			// Reset score combo
			if (invincibility_time <= 0) score_combo = 0;
	        break;
		}
		default:
		{
			// Get input direction
			var input_sign = input_right - input_left;
			
			// Handle ground movement if not sliding down
			if (control_lock_time <= 0)
			{
				if (input_sign != 0)
				{
					// Moving in the opposite direction
					if (x_speed != 0 and sign(x_speed) != input_sign)
					{
						// Braking
						if (animation_index != "brake" and abs(x_speed) > brake_threshold and mask_direction == gravity_direction)
						{
							animation_index = "brake";
							timeline_speed = 1;
							image_xscale = -input_sign;
							audio_play_sfx(sfxBrake);
						}
						
						// Decelerate and reverse direction
						x_speed += land_deceleration * input_sign;
						if (sign(x_speed) == input_sign) x_speed = land_deceleration * input_sign;
					}
					else
					{
						// Accelerate
						image_xscale = input_sign;
						if (abs(x_speed) < speed_cap)
						{
							x_speed += land_acceleration * input_sign;
							if (abs(x_speed) > speed_cap) x_speed = speed_cap * input_sign;
						}
					}
				}
				else
				{
					// Friction
					x_speed -= min(abs(x_speed), land_friction) * sign(x_speed);
				}
			}
			
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not on_ground) return player_is_falling(-1);
			
			// Fall / slide down steep surfaces
	        if (abs(x_speed) < slide_threshold)
	        {
	            if (relative_angle >= 90 and relative_angle <= 270)
	            {
	                return player_is_falling(-1);
	            }
	            else if (relative_angle >= 45 and relative_angle <= 315)
				{
					control_lock_time = default_slide_lock;
				}
	        }
			
			// Slope friction
			player_set_slope_friction(slope_friction);
			
	        // Standing
			if (x_speed == 0 and input_sign == 0)
	        {
	            return player_is_standing(-1);
	        }
			
			// Jumping
	        if (input_action_pressed) return player_is_falling(-2);
			
			// Rolling
			if (input_down and input_sign == 0 and abs(x_speed) >= roll_threshold)
			{
				audio_play_sfx(sfxRoll);
				return player_is_rolling(-1);
			}
			
			// Animate
			if (not ((animation_index == "push" and image_xscale == input_sign) or
					(animation_index == "brake" and timeline_position < 24 and mask_direction == gravity_direction and image_xscale != input_sign)))
	        {
				var velocity = (abs(x_speed) div 1);
				if (velocity < 10)
				{
					animation_index = (velocity < 6) ? "walk" : "run";
				}
				else animation_index = "sprint";
	            timeline_speed = 1 / max(8 - velocity, 1);
	        }
	        image_angle = angle;
			
			// Brake dust
			if (animation_index == "brake" and objScreen.image_index mod 4 == 0)
			{
				var height = y_radius - 6;
				var ox = x + dsin(angle) * height;
				var oy = y + dcos(angle) * height;
				part_particles_create(objResources.particles, ox, oy, objResources.brake_dust, 1);
			}
		}
	}
}

/// @description The player's looking state.
/// @param {Real} phase The state's current step (-1 for starting, 0 for main).
/// @returns {Function} The state that the player will change to given the applicable conditions.
function player_is_looking(phase)
{
	switch (phase)
	{
		case -1:
		{
			// Set state and flags
			state = player_is_looking;
			
			// Reset look time
			camera_look_time = 120;
			
			// Animate
			animation_index = "look";
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not on_ground) return player_is_falling(-1);
			
			// Fall / slide down steep surfaces
	        if (relative_angle >= 90 and relative_angle <= 270)
	        {
	            return player_is_falling(-1);
	        }
	        else if (relative_angle >= 45 and relative_angle <= 315)
			{
				control_lock_time = default_slide_lock;
				return player_is_running(-1);
			}
			
			// Camera panning
			if (camera_look_time > 0)
			{
				--camera_look_time;
			}
			else if (camera.panning_oy > pan_distance_up)
			{
				camera.panning_oy -= 2;
			}
			
	        // Standing
			if (not input_up) return player_is_standing(-1);
			
			// Running
	        if (x_speed != 0) return player_is_running(-1);
			
			// Peelouting
	        if (input_action_pressed) return player_is_peelouting(-1);
		}
	}
}

/// @description The player's crouching state.
/// @param {Real} phase The state's current step (-1 for starting, 0 for main).
/// @returns {Function} The state that the player will change to given the applicable conditions.
function player_is_crouching(phase)
{
	switch (phase)
	{
		case -1:
		{
			// Set state and flags
			state = player_is_crouching;
			
			// Reset look time
			camera_look_time = 120;
			
			// Animate
			animation_index = "crouch";
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not on_ground) return player_is_falling(-1);
			
			// Fall / slide down steep surfaces
	        if (relative_angle >= 90 and relative_angle <= 270)
	        {
	            return player_is_falling(-1);
	        }
	        else if (relative_angle >= 45 and relative_angle <= 315)
			{
				control_lock_time = default_slide_lock;
				return player_is_running(-1);
			}
			
			// Camera panning
			if (camera_look_time > 0)
			{
				--camera_look_time;
			}
			else if (camera.panning_oy < pan_distance_down)
			{
				camera.panning_oy += 2;
			}
			
	        // Standing
			if (not input_down) return player_is_standing(-1);
			
			// Running
	        if (x_speed != 0) return player_is_running(-1);
			
			// Spindashing
	        if (input_action_pressed) return player_is_spindashing(-1);
		}
	}
}

/// @description The player's rolling state.
/// @param {Real} phase The state's current step (-1 for starting, 0 for main).
/// @returns {Function} The state that the player will change to given the applicable conditions.
function player_is_rolling(phase)
{
	switch (phase)
	{
		case -1:
		{
			// Set state and flags
	        state = player_is_rolling;
	        spinning = true;
			
			// Animate
			animation_index = "spin";
			image_angle = gravity_direction;
	        break;
		}
		default:
		{
			if (control_lock_time <= 0)
			{
				// Deceleration
				if (input_left and x_speed > 0)
				{
					x_speed -= roll_deceleration;
					if (x_speed < 0) x_speed = 0;
				}
				if (input_right and x_speed < 0)
				{
					x_speed += roll_deceleration;
					if (x_speed > 0) x_speed = 0;
				}
				
				// Friction
				x_speed -= min(abs(x_speed), roll_friction) * sign(x_speed);
			}
			
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not on_ground) return player_is_falling(-1);
			
			// Fall / slide down steep surfaces
	        if (abs(x_speed) < slide_threshold)
	        {
	            if (relative_angle >= 90 and relative_angle <= 270)
	            {
	                return player_is_falling(-1);
	            }
	            else if (relative_angle >= 45 and relative_angle <= 315)
				{
					control_lock_time = default_slide_lock;
				}
	        }
			
			// Slope friction
			var roll_slope_friction = (sign(x_speed) == sign(dsin(relative_angle))) ? roll_slope_friction_up : roll_slope_friction_down;
			player_set_slope_friction(roll_slope_friction);
			
			// Jumping
	        if (input_action_pressed) return player_is_falling(-2);
			
			// Unroll
			if (abs(x_speed) < unroll_threshold) return player_is_running(-1);
			
			// Animate
			timeline_speed = 1 / max(5 - (abs(x_speed) div 1), 1);
			
	        // Set facing direction
			if ((input_left and x_speed < 0) or (input_right and x_speed > 0))
	        {
	            image_xscale = sign(x_speed);
	        }
		}
	}
}

/// @description The player's spindashing state.
/// @param {Real} phase The state's current step (-1 for starting, 0 for main).
/// @returns {Function} The state that the player will change to given the applicable conditions.
function player_is_spindashing(phase)
{
	switch (phase)
	{
		case -1:
		{
			// Set state and flags
			state = player_is_spindashing;
			spinning = true;
			
			// Reset counters
			spindash_charge = 0;
			
			// Animate
			animation_index = "spindash";
			
			// Sound
			audio_play_sfx(sfxSpinRev);
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not on_ground) return player_is_falling(-1);
			
			// Fall / slide down steep surfaces
	        if (relative_angle >= 90 and relative_angle <= 270)
	        {
	            return player_is_falling(-1);
	        }
	        else if (relative_angle >= 45 and relative_angle <= 315)
			{
				control_lock_time = default_slide_lock;
				return player_is_rolling(-1);
			}
			
	        // Release
			if (not input_down)
			{
				// Launch
				x_speed = image_xscale * (8 + (spindash_charge div 2));
				
				// Camera scroll lag
				camera.alarm[0] = 16;
				
				// Sound
				audio_stop_sound(sfxSpinRev);
				audio_play_sfx(sfxSpinDash);
				
				// Roll
				return player_is_rolling(-1);
			}
			
			// Atrophy
			if (spindash_charge > 0) spindash_charge *= spindash_atrophy;
			
			// Charging
			if (input_action_pressed)
			{
				spindash_charge = min(spindash_charge + 2, 8);
				
				// Sound
				var rev_sound = audio_play_sfx(sfxSpinRev);
				audio_sound_pitch(rev_sound, 1 + spindash_charge * 0.0625);
			}
		}
	}
}

/// @description The player's peelouting state.
/// @param {Real} phase The state's current step (-1 for starting, 0 for main).
/// @returns {Function} The state that the player will change to given the applicable conditions.
function player_is_peelouting(phase)
{
	switch (phase)
	{
		case -1:
		{
			// Set state and flags
			state = player_is_peelouting;
			
			// Reset counters
			peelout_charge = 0;
			
			// Animate
			animation_index = "walk";
			timeline_speed = 0.5;
			
			// Sound
			audio_play_sfx(sfxPeeloutRev);
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not on_ground) return player_is_falling(-1);
			
			// Fall / slide down steep surfaces
	        if (relative_angle >= 90 and relative_angle <= 270)
	        {
	            return player_is_falling(-1);
	        }
	        else if (relative_angle >= 45 and relative_angle <= 315)
			{
				control_lock_time = default_slide_lock;
				return player_is_running(-1);
			}
			
	        // Release
			if (not input_up)
			{
				// Launch if fully charged
				if (peelout_charge >= 30)
				{
					x_speed = image_xscale * 12;
					audio_stop_sound(sfxPeeloutRev);
					audio_play_sfx(sfxPeelout);
					return player_is_running(-1);
				}
				else return player_is_standing(-1);
			}
			
			// Charge and animate
			if (peelout_charge < 30 and ++peelout_charge mod 15 == 0)
			{
				animation_index = (peelout_charge < 30) ? "run" : "sprint";
			}
		}
	}
}
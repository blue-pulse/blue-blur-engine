/// @description The player's transitionary state until the stage has begun.
/// @returns {Function} The player's standing state.
function player_is_starting() {
	timeline_running = true;
	return player_is_standing(-1);
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
	        is_rolling = false;
			
			// Reset score combo
			if (invincibility_timer <= 0) score_combo = 0;
			
			// Find the direction of the nearest cliff
			player_update_cliff();
			
			// Animate
			animation_index = (cliff_dir != 0) ? "teeter" : "idle";
			timeline_speed = 1;
			image_angle = gravity_direction;
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not is_grounded) return player_is_falling(-1);
			
			// Fall / slide down steep surfaces
	        if (relative_angle >= 90 and relative_angle <= 270)
	        {
	            return player_is_falling(-1);
	        }
			else if (relative_angle >= 45 and relative_angle <= 315)
			{
				gnd_lock = slide_timer;
				return player_is_running(-1);
			}

	        // Running
	        if (input_check(vb_left) or input_check(vb_right) or hor_speed != 0)
	        {
	            return player_is_running(-1);
	        }
			
			// Jumping
	        if (input_pressed(vb_a)) return player_is_falling(-2);
			
			// Looking/crouching
			if (cliff_dir == 0)
			{
				if (input_check(vb_up)) return player_is_looking(-1);
				if (input_check(vb_down)) return player_is_crouching(-1);
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
	        is_rolling = false;
			
			// Reset score combo
			if (invincibility_timer <= 0) score_combo = 0;
	        break;
		}
		default:
		{
			// Get input direction
			var input_sign = input_check(vb_right) - input_check(vb_left);
			
			// Handle ground movement if not sliding down
			if (gnd_lock <= 0)
			{
				if (input_sign != 0)
				{
					// Moving in the opposite direction
					if (hor_speed != 0 and sign(hor_speed) != input_sign)
					{
						// Braking
						if (animation_index != "brake" and abs(hor_speed) > brake_threshold and mask_direction == gravity_direction)
						{
							animation_index = "brake";
							timeline_speed = 1;
							image_xscale = -input_sign;
							//audio_play_sfx(sfxBrake);
						}
						
						// Decelerate and reverse direction
						hor_speed += land_deceleration * input_sign;
						if (sign(hor_speed) == input_sign) hor_speed = land_deceleration * input_sign;
					}
					else
					{
						// Accelerate
						image_xscale = input_sign;
						if (abs(hor_speed) < speed_cap)
						{
							hor_speed += land_acceleration * input_sign;
							if (abs(hor_speed) > speed_cap) hor_speed = speed_cap * input_sign;
						}
					}
				}
				else
				{
					// Friction
					hor_speed -= min(abs(hor_speed), land_friction) * sign(hor_speed);
				}
			}
			
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not is_grounded) return player_is_falling(-1);
			
			// Fall / slide down steep surfaces
	        if (abs(hor_speed) < slide_threshold)
	        {
	            if (relative_angle >= 90 and relative_angle <= 270)
	            {
	                return player_is_falling(-1);
	            }
	            else if (relative_angle >= 45 and relative_angle <= 315)
				{
					gnd_lock = slide_timer;
				}
	        }
			
			// Slope friction
			player_set_friction(slope_frict);
			
	        // Standing
			if (hor_speed == 0 and input_sign == 0)
	        {
	            return player_is_standing(-1);
	        }
			
			// Jumping
	        if (input_pressed(vb_a)) return player_is_falling(-2);
			
			// Rolling
			if (input_check(vb_down) and input_sign == 0 and abs(hor_speed) >= roll_threshold)
			{
				//audio_play_sfx(sfxRoll);
				return player_is_rolling(-1);
			}
			
			// Animate
			if (not ((animation_index == "push" and image_xscale == input_sign) or
					(animation_index == "brake" and timeline_position < 24 and mask_direction == gravity_direction and image_xscale != input_sign)))
	        {
				var velocity = (abs(hor_speed) div 1);
				if (velocity < 10)
				{
					animation_index = (velocity < 6) ? "walk" : "run";
				}
				else animation_index = "sprint";
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
			
			// Animate
			animation_index = "look";
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not is_grounded) return player_is_falling(-1);
			
			// Fall / slide down steep surfaces
	        if (relative_angle >= 90 and relative_angle <= 270)
	        {
	            return player_is_falling(-1);
	        }
	        else if (relative_angle >= 45 and relative_angle <= 315)
			{
				gnd_lock = slide_timer;
				return player_is_running(-1);
			}
			
	        // Standing
			if (not input_check(vb_up)) return player_is_standing(-1);
			
			// Running
	        if (hor_speed != 0) return player_is_running(-1);
			
			// Peelouting
	        if (input_pressed(vb_a)) return player_is_peelouting(-1);
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
			
			// Animate
			animation_index = "crouch";
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not is_grounded) return player_is_falling(-1);
			
			// Fall / slide down steep surfaces
	        if (relative_angle >= 90 and relative_angle <= 270)
	        {
	            return player_is_falling(-1);
	        }
	        else if (relative_angle >= 45 and relative_angle <= 315)
			{
				gnd_lock = slide_timer;
				return player_is_running(-1);
			}
			
	        // Standing
			if (not input_check(vb_down)) return player_is_standing(-1);
			
			// Running
	        if (hor_speed != 0) return player_is_running(-1);
			
			// Spindashing
	        if (input_pressed(vb_a)) return player_is_spindashing(-1);
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
	        is_rolling = true;
			
			// Animate
			animation_index = "spin";
			image_angle = gravity_direction;
	        break;
		}
		default:
		{
			if (gnd_lock <= 0)
			{
				// Deceleration
				if (input_check(vb_left) and hor_speed > 0)
				{
					hor_speed -= roll_deceleration;
					if (hor_speed < 0) hor_speed = 0;
				}
				if (input_check(vb_right) and hor_speed < 0)
				{
					hor_speed += roll_deceleration;
					if (hor_speed > 0) hor_speed = 0;
				}
				
				// Friction
				hor_speed -= min(abs(hor_speed), roll_friction) * sign(hor_speed);
			}
			
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not is_grounded) return player_is_falling(-1);
			
			// Fall / slide down steep surfaces
	        if (abs(hor_speed) < slide_threshold)
	        {
	            if (relative_angle >= 90 and relative_angle <= 270)
	            {
	                return player_is_falling(-1);
	            }
	            else if (relative_angle >= 45 and relative_angle <= 315)
				{
					gnd_lock = slide_timer;
				}
	        }
			
			// Slope friction
			var roll_slope_friction = (sign(hor_speed) == sign(dsin(relative_angle))) ? slope_frict_up : slope_frict_down;
			player_set_friction(roll_slope_friction);
			
			// Jumping
	        if (input_pressed(vb_a)) return player_is_falling(-2);
			
			// Unroll
			if (abs(hor_speed) < unroll_threshold) return player_is_running(-1);
			
			// Animate
			timeline_speed = 1 / max(5 - (abs(hor_speed) div 1), 1);
			
	        // Set facing direction
			if ((input_check(vb_left) and hor_speed < 0) or (input_check(vb_right) and hor_speed > 0))
	        {
	            image_xscale = sign(hor_speed);
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
			is_rolling = true;
			
			// Reset counters
			spindash_charge = 0;
			
			// Animate
			animation_index = "spindash";
			
			// Sound
			//audio_play_sfx(sfxSpinRev);
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not is_grounded) return player_is_falling(-1);
			
			// Fall / slide down steep surfaces
	        if (relative_angle >= 90 and relative_angle <= 270)
	        {
	            return player_is_falling(-1);
	        }
	        else if (relative_angle >= 45 and relative_angle <= 315)
			{
				gnd_lock = slide_timer;
				return player_is_rolling(-1);
			}
			
	        // Release
			if (not input_check(vb_down))
			{
				// Launch
				hor_speed = image_xscale * (8 + (spindash_charge div 2));
				
				// Camera scroll lag
				//camera.alarm[0] = 16;
				
				// Sound
				audio_stop_sound(sfxSpinRev);
				//audio_play_sfx(sfxSpinDash);
				
				// Roll
				return player_is_rolling(-1);
			}
			
			// Atrophy
			if (spindash_charge > 0) spindash_charge *= spindash_atrophy;
			
			// Charging
			if (input_pressed(vb_a))
			{
				spindash_charge = min(spindash_charge + 2, 8);
				
				// Sound
				//var rev_sound = //audio_play_sfx(sfxSpinRev);
				//audio_sound_pitch(rev_sound, 1 + spindash_charge * 0.0625);
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
			//audio_play_sfx(sfxPeeloutRev);
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not is_grounded) return player_is_falling(-1);
			
			// Fall / slide down steep surfaces
	        if (relative_angle >= 90 and relative_angle <= 270)
	        {
	            return player_is_falling(-1);
	        }
	        else if (relative_angle >= 45 and relative_angle <= 315)
			{
				gnd_lock = slide_timer;
				return player_is_running(-1);
			}
			
	        // Release
			if (not input_check(vb_up))
			{
				// Launch if fully charged
				if (peelout_charge >= 30)
				{
					hor_speed = image_xscale * 12;
					audio_stop_sound(sfxPeeloutRev);
					//audio_play_sfx(sfxPeelout);
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
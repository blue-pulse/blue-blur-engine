function player_is_rolling(phase)
{
	switch (phase)
	{
		case INIT:
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
			var roll_slope_friction = (sign(hor_speed) == sign(dsin(relative_angle))) ? slope_frict_up : slope_frict_down;
			player_set_friction(roll_slope_friction);
			
			// Jumping
	        if (input_pressed(vb_a)) return player_is_falling(-2);
			
			// Unroll
			if (abs(hor_speed) < unroll_threshold) return player_is_running(INIT);
			
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
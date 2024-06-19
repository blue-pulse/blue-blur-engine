function handle_player_roll_movement() {
	// Decelerate
	if !ground_lock
	{
		if input_check("btn_left")
		{
			if ground_speed > 0
			{
				ground_speed -= roll_decel;
				if ground_speed < 0
				{
					ground_speed = -0.5;
				}
			}
			else
			{
				is_pushing = false;
				facing  = left;
			}
		}
		if input_check("btn_right")
		{
			if ground_speed < 0
			{
				ground_speed += roll_decel;
				if ground_speed >= 0
				{
					ground_speed = 0.5;
				}
			}
			else
			{
				is_pushing = false;
				facing  = right;
			}
		}
	}

	// Apply friction
	if ground_speed > 0
	{
		ground_speed = max(ground_speed - RollFrc, 0);
	}
	else if ground_speed < 0
	{
		ground_speed = min(ground_speed + RollFrc, 0);
	}
	
	// Convert ground inertia to speeds
	horizontal_speed = ground_speed *  dcos(angle);
	vertical_speed = ground_speed * -dsin(angle);
	
	// Limit rolling speed
	horizontal_speed = clamp(horizontal_speed, -16, 16);

	// Unroll
	if !forced_roll
	{
		if ground_speed == 0 
		{
			pos_y     -= default_radius[1] - small_radius[1];
			radius_x   = default_radius[0];
			radius_y   = default_radius[1];		
			is_spinning = false;
			set_state(idle);
		}
	}
	
	// If forced to roll, continue rolling
	else if ground_speed == 0
	{
		ground_speed = 2;
	}
}
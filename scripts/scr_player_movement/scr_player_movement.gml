function handle_player_ground_movement() {	
	if spindash_revolution != -1 {
		return;
	}
	
	if !ground_lock 
	{
		if input_check("btn_left")
		{	
			// Decelerate
			if ground_speed > 0 
			{
				ground_speed -= decel;
				if ground_speed <= 0
				{
					ground_speed = -0.5;
				}
			} 
			
			// Accelerate
			else
			{
				if facing != left
				{
					facing  = left;
					is_pushing = false;
					
					//animation_reset(0);
				}
				if ground_speed > -top_accel
				{
					ground_speed = max(ground_speed - accel, -top_accel);
				} 
			}
		}
		else if input_check("btn_right")
		{			
			// Decelerate
			if ground_speed < 0 
			{
				ground_speed += decel;
				if ground_speed >= 0
				{
					ground_speed = 0.5;
				}
			} 
			
			// Accelerate
			else
			{
				if facing != right
				{
					facing  = right;
					is_pushing = false;
					
					//animation_reset(0);
				}
				if ground_speed < top_accel
				{
					ground_speed = min(ground_speed + accel, top_accel);
				} 
			}
		}
		
		// Perform skid. angle check here is different in comparison to collision mode checks
		if (angle <= 45 or angle >= 316.41) and get_state() != skidding
		{
			if input_check("btn_left") and ground_speed >= 4 or input_check("btn_right") and ground_speed <= -4
			{
				set_state(skidding);
						
				//audio_sfx_play(sfxSkid, false);
				//instance_create(pos_x, pos_y + radius_y, DustPuff);
			}
		}
	}
	
	// Apply friction
	if !input_check("btn_left") and !input_check("btn_right")
	{
		if ground_speed > 0
		{
			ground_speed = max(ground_speed - frict, 0);
		}
		else
		{
			ground_speed = min(ground_speed + frict, 0);
		}
		is_pushing = false;
	}

	// Convert ground inertia to speed
	horizontal_speed = ground_speed * dcos(angle);
	vertical_speed = ground_speed * -dsin(angle);

	// Set animation
	if is_pushing
	{
		set_state(pushing);
	}
	else if ground_speed == 0
	{
		// Same unsymmetrical angle check, just like above...
		if (angle <= 45 or angle >= 316.41)
		{
			if input_check("btn_up")
			{
				set_state(looking_up);
			}
			else if input_check("btn_down")
			{
				set_state(crouching);
			}
			else
			{
				set_state(idle);
			}
		}
	}
	else
	{
		if get_state() != skidding
		{
			set_state(moving);
		}
		else if ground_speed > 0 and input_check("btn_right") or ground_speed < 0 and input_check("btn_left")
		{
			set_state(moving);
		}
	}
}

function handle_player_roll_movement() {

}
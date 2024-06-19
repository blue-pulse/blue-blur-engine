function handle_player_air_movement() {	
	// Rotate angle back to 360 degrees
	if angle < 180
	{
		angle = max(angle - 2.8125, 0);
	}
	else
	{
		angle = min(angle + 2.8125, 360);
	}
	
	// Limit vertical speed if not jumping
	if vertical_speed < -15.75 and !is_jumping
	{
		vertical_speed = -15.75;
	}
	
	if !air_lock
	{
		if input_check("btn_left")
		{	
			// Decelerate
			if horizontal_speed > 0 
			{
				horizontal_speed -= air_accel;
			} 
			
			// Accelerate
			else if horizontal_speed > -top_accel
			{
				horizontal_speed -= air_accel;
				if horizontal_speed <= -top_accel
				{
					horizontal_speed = -top_accel;
				}
			}
			facing = left;
		}
		if input_check("btn_right")
		{	
			// Decelerate
			if horizontal_speed < 0 
			{
				horizontal_speed += air_accel;
			} 
			
			// Accelerate
			else if horizontal_speed < top_accel
			{
				horizontal_speed += air_accel;
				if horizontal_speed >= top_accel
				{
					horizontal_speed = top_accel;
				}
			}
			facing = right;
		}	
	}
	
	// Apply air drag
	if vertical_speed < 0 and vertical_speed > -4 and !is_hurt
	{
		horizontal_speed -= floor(horizontal_speed / 0.125) / 256;
	}
}
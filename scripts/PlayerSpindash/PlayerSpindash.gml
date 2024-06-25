function PlayerSpindash()
{
	if !global.SpindashEnabled
	{
		return;
	}
	
	// Start spindash
	if spindash_revolutions == -1
	{
		if state == states.crouching and input_check_pressed("btn_1")
		{
			spindash_revolutions = 0;
			horizontal_speed			= 0;
		}
	}
	
	// Charge spindash
	else if button_check("btn_down")
	{
		if input_check_pressed("btn_1")
		{
			spindash_revolutions = min(spindash_revolutions + 2, 8);
			
			//animation_reset(0);
			//audio_sfx_play(sfxCharge, false);
		}
		else
		{
			spindash_revolutions -= floor(spindash_revolutions / 0.125) / 256;
		}
	}
	
	// Release spindash
	else
	{
		if !global.CDCamera
		{
			//Camera.ScrollDelay = 16;
		}
		
		ground_speed	        = ((SuperState ? 11 : 8) + round(spindash_revolutions) / 2) * facing;
		is_rolling    = true;
		spindash_revolutions = -1;
		state   = states.rolling;
			
		radius_x	= small_radius_x;
		radius_y	= small_radius_y;
		pos_y   += default_radius_y - small_radius_y;
		
		// Convert ground_speed to speed. Originals don't do this, so you could jump straight upwards there!
		if global.FixDashRelease
		{
			horizontal_speed = ground_speed *  dcos(angle);
			vertical_speed = ground_speed * -dsin(angle);
		}
	}
	
	// Apply spindash animation
	if spindash_revolutions >= 0
	{
		state = states.spindash;
	}
	
	return is_rolling;
}
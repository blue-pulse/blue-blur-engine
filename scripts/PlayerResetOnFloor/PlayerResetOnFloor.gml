function PlayerResetOnFloor()
{	
	// Wait until player has landed
	if !is_grounded
	{
		return;
	}
	
	// Is water barrier active?
	if BarrierIsActive and BarrierType == BarrierWater 
	{
		var Force = (is_underwater) ? (-4) : (-7.5);
		vertical_speed		  = Force * dcos(angle);
		horizontal_speed       = Force * dsin(angle);
		
		BarrierIsActive = false;
		is_grounded        = false;
		on_object	    = false;
	}
	else
	{
		// Update player animation
		if !on_object and state != states.idle
		{
			if  state != states.spindash
			{
				state = states.moving;
			}
		}
		
		// Reset flags
		if is_being_hurt
		{
			is_being_hurt = false;
			ground_speed  = 0;
		}
		is_rolling		 = false;
		is_jumping			 = false;
		air_lock			 = false;
		is_pushing			 = false;
		ScoreCombo		 = false;
		BarrierIsActive  = false;
	
		// Update visual angle if floor is steep enough
		if global.SmoothRotation and angle >= 35.16 and angle <= 324.84
		{
			rotation = angle;
		}
		
		// Reset gravity
		if !is_underwater
		{
			gravity_force = 0.21875;
		}
		else
		{
			// Reduce by 0x28 (0.15625) if underwater
			gravity_force = 0.0625
		}
		
		// Release/reset dropdash
		if DropdashRev == 20
		{	
			if radius_y != small_radius_y
			{
				pos_y   -= small_radius_y - radius_y;
				radius_x = small_radius_x;
				radius_y = small_radius_y;
			}
			if SuperState
			{
				var DropForce = 12;
				var MaxForce  = 13;
			}
			else
			{
				var DropForce = 8;
				var MaxForce  = 12;
			}
		
			// Define dropspeed
			if DropdashSide == right
			{
				var Dropspeed = ground_speed / 4 + DropForce * facing;
			}
			else if DropdashSide == left
			{
				if angle == 360
				{
					var Dropspeed = DropForce * facing;
				}
				else
				{
					var Dropspeed = ground_speed / 2 + DropForce * facing;
				}
			}
			Dropspeed = clamp(Dropspeed, -MaxForce, MaxForce);
			
			// Shake and/or delay camera
			if !global.CDCamera
			{
				//Camera.ScrollDelay = 16;
			}
			
			// Apply dropspeed
			ground_speed			= Dropspeed;
			DropdashRev = -1;
			is_rolling    = true;
			state   = states.rolling;
		}
		else
		{
			DropdashRev = -1;
		}
	
		// Reset collision radiuses if not rolling
		if !is_rolling
		{
			pos_y   -= default_radius_y - radius_y;
			radius_x	= default_radius_x;
			radius_y = default_radius_y; 
		}
	}
}

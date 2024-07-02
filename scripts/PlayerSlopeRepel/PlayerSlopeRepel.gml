function PlayerSlopeRepel() 
{
	if stick_to_convex
	{
		return;
	}
	
	// Decrease timer every frame when is_grounded if non-zero
	if ground_lock
	{
		ground_lock--;
	}
	
	// Check if we are on a steep slope and going slow
	else
	{
		if !global.S3SlopePhysics
		{	
			// angle check here is different in comparison to collision mode checks
			if angle >= 46.41 and angle <= 315 and abs(ground_speed) < 2.5
			{	
				is_grounded   = false;
				ground_lock = 30;
				ground_speed		   = 0;		
			} 
		}
		else
		{
			if angle >= 35.16 and angle <= 326.25 and abs(ground_speed) < 2.5
			{
				if angle >= 68.91 and angle <= 292.5
				{
					is_grounded = false;
				}
				else
				{
					ground_speed += (angle > 180) ? (0.5) : (-0.5);
				}
				ground_lock = 30;
			}
		}	
	}
}
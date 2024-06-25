function PlayerRotation()
{
	if state != states.moving
	{
		rotation = 360;
	}
	else
	{
		// Apply smooth rotation
		if global.SmoothRotation
		{
			if is_grounded
			{
				/* Smooth rotation code by Nihil (NullSpace)
				Used with permission! */
				
				if angle >= 35.16 and angle <= 324.84
				{
					var TargetAngle  = angle;
					var RotationStep = (abs(ground_speed) / 16 + abs(ground_speed) / 32 - 2) * -1
				}
				else
				{
					var TargetAngle  = 360;
					var RotationStep = (abs(ground_speed) / 16 - 2) * -1
				}
				rotation = darctan2(dsin(TargetAngle) + dsin(rotation) * RotationStep, dcos(TargetAngle) + dcos(rotation) * RotationStep);	
			}
			else
			{
				// Rotate back to 360
				if rotation <= 0
				{
					rotation += 360;
				}
				if rotation < 180
				{
					rotation = max(rotation - 2.8125, 0);
				}
				else
				{
					rotation = min(rotation + 2.8125, 360);
				}	
			}
		}
	
		// Apply regular classic-like rotation
		else if angle >= 23.91 and angle <= 337.5
		{	
			rotation = ceil((angle - 22.5) / 45) * 45;
		}
		else
		{
			rotation = 360;
		}
	}
}
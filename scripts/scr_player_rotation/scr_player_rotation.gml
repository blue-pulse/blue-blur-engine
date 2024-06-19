function handle_player_rotation()
{
	if get_state() != moving
	{
		rotation = 360;
	}
	else
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
}
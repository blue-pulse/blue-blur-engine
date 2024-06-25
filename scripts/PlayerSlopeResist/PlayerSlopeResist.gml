function PlayerSlopeResist()
{	
	// Exit if on ceiling. angle check here is different in comparison to collision mode checks
	if angle <= 225 and angle >= 136.41
	{
		return;
	}
	
	// Set slope gravity
	slope_gravity = 0.125 * dsin(angle);
	
	// Apply it
	if ground_speed != 0
	{
		ground_speed -= slope_gravity;
	}
	else if global.S3SlopePhysics and abs(slope_gravity) > 0.05078125
	{
		ground_speed -= slope_gravity;
	}
}
function PlayerSlopeResistRoll()
{
	// Exit if on ceiling. angle check here is different in comparison to collision mode checks
	if angle <= 225 and angle >= 136.41
	{
		return;
	}
	
	// Set slope gravity and then apply it
	if sign(ground_speed) != sign(dsin(angle))
	{
		slope_gravity = 0.3125 * dsin(angle);
	}
	else
	{
		slope_gravity = 0.078125 * dsin(angle);
	}
	ground_speed -= slope_gravity;
}
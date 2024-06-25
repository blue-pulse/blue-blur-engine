function PlayerRollStart()
{
	if !ForcedRoll and (button_check("btn_left") or button_check("btn_right")) or spindash_revolutions != -1
	{
		return;
	}
	
	// Check if we should roll up
	var ManualRoll = false;
	if  button_check("btn_down")
	{
		if global.SKCrouch
		{
			if abs(ground_speed) >= 1
			{
				ManualRoll = true;
			}
			else
			{
				state = states.crouching;
			}
		}
		else if abs(ground_speed) >= 0.5
		{
			ManualRoll = true;
		}
	}
	
	// Roll up
	if ManualRoll or ForcedRoll
	{
		pos_y     += default_radius_y - small_radius_y;
		radius_y   = small_radius_y;
		radius_x	  = small_radius_x;
		is_rolling  = true;
		state = states.rolling;
	}
}
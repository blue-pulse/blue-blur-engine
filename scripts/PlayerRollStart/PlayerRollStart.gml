function PlayerRollStart() {
	// Verify initial conditions
	if (is_grounded and !is_rolling) {
	}
	
	if !forced_roll and (button_check("btn_left") or button_check("btn_right")) or spindash_revolutions != -1
	{
		return;
	}
	
	// Check if we should roll up
	var manual_roll = false;
	if  button_check("btn_down")
	{
		if global.SKCrouch
		{
			if abs(ground_speed) >= 1
			{
				manual_roll = true;
			}
			else
			{
				state = states.crouching;
			}
		}
		else if abs(ground_speed) >= 0.5
		{
			manual_roll = true;
		}
	}
	
	// Roll up
	if manual_roll or forced_roll
	{
		pos_y     += default_radius_y - small_radius_y;
		radius_y   = small_radius_y;
		radius_x	  = small_radius_x;
		is_rolling  = true;
		state = states.rolling;
	}
}
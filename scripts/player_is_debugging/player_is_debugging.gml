function player_is_debugging(phase)
{
	switch (phase)
	{
		case INIT:
		{
			// Set state and flags
			state = player_is_debugging;
			is_rolling = false;
			
			// Movement
			hor_speed = 0;
			ver_speed = 0;
			
			// Set air state
			player_set_ground(noone);
			break;
		}
		default:
		{
			// Fly around, whilst staying within bounds
			x += (input_check(vb_right) - input_check(vb_left)) * 8;
			y += (input_check(vb_down) - input_check(vb_up)) * 8;
			player_in_view();
		}
	}
}
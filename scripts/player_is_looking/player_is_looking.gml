function player_is_looking(phase)
{
	switch (phase)
	{
		case INIT:
		{
			// Set state and flags
			state = player_is_looking;
			
			// Animate
			animation_index = "look";
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_ground()) exit;
			
			// Falling
			if (not is_grounded) return player_is_falling(INIT);
			
			// Fall / slide down steep surfaces
	        if (relative_angle >= 90 and relative_angle <= 270)
	        {
	            return player_is_falling(INIT);
	        }
	        else if (relative_angle >= 45 and relative_angle <= 315)
			{
				gnd_lock = slide_timer;
				return player_is_running(INIT);
			}
			
	        // Standing
			if (not input_check(vb_up)) return player_is_standing(INIT);
			
			// Running
	        if (hor_speed != 0) return player_is_running(INIT);
			
			// Peelouting
	        if (input_pressed(vb_a)) return player_is_peelouting(INIT);
		}
	}
}
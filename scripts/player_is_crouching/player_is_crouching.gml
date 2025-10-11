function player_is_crouching(phase)
{
	switch (phase)
	{
		case INIT:
		{
			// Set state and flags
			state = player_is_crouching;
			
			// Animate
			animation_index = "crouch";
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
				return player_state_run(INIT);
			}
			
	        // Standing
			if (not input_check(vb_down)) {
				player_set_state(player_state_idle);
				exit;
			}
			
			// Running
	        if (hor_speed != 0) return player_state_run(INIT);
			
			// Spindashing
	        if (input_pressed(vb_a)) return player_is_spindashing(INIT);
		}
	}
}
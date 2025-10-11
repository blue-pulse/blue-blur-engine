function player_is_peelouting(phase)
{
	switch (phase)
	{
		case INIT:
		{
			// Set state and flags
			state = player_is_peelouting;
			
			// Reset counters
			peelout_charge = 0;
			
			// Animate
			animation_index = "walk";
			timeline_speed = 0.5;
			
			// Sound
			//audio_play_sfx(sfxPeeloutRev);
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
				player_set_state(player_state_run);
				exit;
			}
			
	        // Release
			if (not input_holded(vb_up))
			{
				// Launch if fully charged
				if (peelout_charge >= 30)
				{
					hor_speed = image_xscale * 12;
					//audio_stop_sound(sfxPeeloutRev);
					//audio_play_sfx(sfxPeelout);
					player_set_state(player_state_run);
					exit;
				}
				else {
					player_set_state(player_state_idle);
					exit;
				}
			}
			
			// Charge and animate
			if (peelout_charge < 30 and ++peelout_charge mod 15 == 0)
			{
				animation_index = (peelout_charge < 30) ? "run" : "sprint";
			}
		}
	}
}
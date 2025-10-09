function player_is_spindashing(phase)
{
	switch (phase)
	{
		case INIT:
		{
			// Set state and flags
			state = player_is_spindashing;
			is_rolling = true;
			
			// Reset counters
			spindash_charge = 0;
			
			// Animate
			animation_index = "spindash";
			
			// Sound
			//audio_play_sfx(sfxSpinRev);
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
				return player_is_rolling(INIT);
			}
			
	        // Release
			if (not input_check(vb_down))
			{
				// Launch
				hor_speed = image_xscale * (8 + (spindash_charge div 2));
				
				// Camera scroll lag
				//camera.alarm[0] = 16;
				
				// Sound
				//audio_stop_sound(sfxSpinRev);
				//audio_play_sfx(sfxSpinDash);
				
				// Roll
				return player_is_rolling(INIT);
			}
			
			// Atrophy
			if (spindash_charge > 0) spindash_charge *= spindash_atrophy;
			
			// Charging
			if (input_pressed(vb_a))
			{
				spindash_charge = min(spindash_charge + 2, 8);
				
				// Sound
				//var rev_sound = //audio_play_sfx(sfxSpinRev);
				//audio_sound_pitch(rev_sound, 1 + spindash_charge * 0.0625);
			}
		}
	}
}
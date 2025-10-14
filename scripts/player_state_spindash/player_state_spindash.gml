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
			audio_play_sfx(snd_player_spindash_charge, REPLACE);
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
				ground_lock = stumble_timer;
				return player_is_rolling(INIT);
			}
			
	        // Release
			if (not input_holded(vb_down))
			{
				// Launch
				hor_speed = image_xscale * (8 + (spindash_charge div 2));
				
				// Camera
				screen_shake(15);
				
				// Sound
				audio_stop_sound(snd_player_spindash_charge);
				audio_play_sfx(snd_player_spindash_release, REPLACE);
				
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
				var rev_sound = audio_play_sfx(snd_player_spindash_charge, REPLACE);
				audio_sound_pitch(rev_sound, 1 + spindash_charge * 0.0625);
			}
		}
	}
}
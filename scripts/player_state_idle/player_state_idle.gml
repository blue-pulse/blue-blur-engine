function player_is_standing(phase) {
	switch (phase) {
		case INIT:
			// Set state and flags
			state = player_is_standing;
	        is_rolling = false;
			
			// Reset score combo
			if (invincibility_timer <= 0) {
				score_combo = 0;
			}
			
			// Find the direction of the nearest cliff
			player_update_cliff();
			
			// Animate idle
			if (cliff_dir == 0) {
				player_play_anim(anim_idle);
			}
			
			// Animate balance
			else {
				if (cliff_dir == image_xscale) {
					player_play_anim(anim_balance_front);
				} else {
					player_play_anim(anim_balance_back);
				}
			}
			image_angle = gravity_direction;
			break;
		
		default:
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

	        // Running
	        if (input_check(vb_left) or input_check(vb_right) or hor_speed != 0)
	        {
	            return player_is_running(INIT);
	        }
			
			// Jumping
	        if (input_pressed(vb_a)) return player_is_falling(-2);
			
			// Looking/crouching
			if (cliff_dir == 0)
			{
				if (input_check(vb_up)) return player_is_looking(INIT);
				if (input_check(vb_down)) return player_is_crouching(INIT);
			}
	}
}
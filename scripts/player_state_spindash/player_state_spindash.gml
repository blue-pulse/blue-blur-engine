function player_state_spindash() {
	if (is_grounded and !is_rolling) {
		// Start spindash
		if (spindash_revolutions == -1) {
			if ((state == states.crouching) and button_check_pressed("btn_1")) {
				spindash_revolutions = 0;
				horizontal_speed = 0;
			}
		} else if button_check("btn_down") {
			// Charge spindash
			if (button_check_pressed("btn_1")) {
				spindash_revolutions = min(spindash_revolutions + 2, 8);
			
				//animation_reset(0);
				//audio_sfx_play(sfxCharge, false);
			} else {
				spindash_revolutions -= floor(spindash_revolutions / 0.125) / 256;
			}
		} else {
			// Release spindash
			ground_speed = (8 + round(spindash_revolutions) / 2) * facing;
			is_rolling = true;
			spindash_revolutions = -1;
			state = states.rolling;
			
			radius_x = small_radius_x;
			radius_y = small_radius_y;
			pos_y += default_radius_y - small_radius_y;
		
			// Convert ground_speed to speed
			horizontal_speed = ground_speed * dcos(angle);
			vertical_speed = ground_speed * -dsin(angle);
		}
	
		// Apply spindash animation
		if (spindash_revolutions >= 0) {
			state = states.spindash;
		}
	}
}
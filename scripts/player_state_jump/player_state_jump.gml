function player_state_jump(phase) {
	switch (phase) {
		// Start state
	    case INIT:
			// Set Variables
	        is_rolling = true;
	        is_jumping = true;
	        jump_action = true;
			player_set_ground(noone);

	        // Movement
			var sine = dsin(relative_angle);
			var cosine = dcos(relative_angle);
			ver_speed = (-sine * hor_speed) - (cosine * jump_height);
	        hor_speed = (cosine * hor_speed) - (sine * jump_height);

			// Animate
			var current_speed = abs(hor_speed);
			var anim_speed = map(current_speed, 0, 8, 2, 3);
			animation_play(anim_spin_fast, anim_speed);
	        image_angle = gravity_direction;
			
			// Sound
			//audio_play_sfx(sfxJump);
	        break;
		
		// Run state
	    case STEP:
			player_set_state(player_state_airbone, STEP);
	        break;
		
		// Stop state
	    case STOP:
	        break;
	}
}

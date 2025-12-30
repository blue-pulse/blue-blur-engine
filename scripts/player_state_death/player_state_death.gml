function player_state_death(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Set variables
			is_rolling = false;
			recovery_timer = 0;
			invincibility_frames = 0;
			objStage.timer_enabled = false;
			
			// Remove effects
			instance_destroy(invincibility_fx);
			
			// FX
			depth = queue.effects;
			animation_play(anim_hurt);
			//audio_play_sfx(sfxDeath);
			break;

		// Run state
		case STEP:
			// Update position
			x += hor_speed;
			y += ver_speed;
			
			// Gravity
			if (ver_speed < grav_cap) {
				ver_speed = min(ver_speed + grav_recoil, grav_cap);
			}
			
			// Finish
			if (!in_view(id, 24) and ver_speed > 3) {
				// Reduce life counter
				if (--global.lives <= 0 or objStage.time_over) {
					//instance_create_layer(0, 0, "Overlays", objGameOver);
				}
				
				// If not, restart
				else {
					objStage.reset_time = 60; 
				}
				instance_destroy();
			}
			break;
		
		// Stop state
		case STOP:
			break;
	}
}

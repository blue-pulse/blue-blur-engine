function player_state_death(phase) {
	switch (phase) {
		// Start state
		case INIT:
			// Set variables
			is_rolling = false;
			recovery_timer = 0;
			
			// FX
			depth = depths.effects;
			animation_play(anim_hurt);
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
				if (--global.lives <= 0) {
					//instance_create_layer(0, 0, "Overlays", objGameOver);
				}
				
				// If not, restart
				else {
					Stage.reset_timer = 60; 
				}
				instance_destroy();
			}
			break;
		
		// Stop state
		case STOP:
			break;
	}
}

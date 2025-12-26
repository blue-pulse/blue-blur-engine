function sonic_begin_homing() {
	// Create reticle
	if (!instance_exists(Reticle)) {
		if (allow_jump_action) {
			// Record targets
			var target_list = [
				instance_nearest(x, y, objMonitor), 
				instance_nearest(x, y, objBadnik), // Higher priority
			];

			// Evaluate all targets
			for (var i = array_length(target_list) - 1; i > -1; --i) {
				// Get the current target
				var target = target_list[i];
				
				// Lock on to it if possible
				if (target != noone and player_can_lock_on(target)) {
					var reticle = vfx_create(target.x, target.y, Reticle);
					reticle.target = target;
					reticle.owner = id;
					exit;
				}
			}
		}
	}

	// Destroy reticle
	else if (!player_can_lock_on(Reticle.target)) {
		instance_destroy(Reticle);
	}

	// Perform a homing action
	if (allow_jump_action and input_pressed(vb_a)) {
		// Burst effect and sound
		part_particles_create(Particles, x, y, global.homing_burst, 1);
		audio_play_sfx(snd_player_homing_dash, REPLACE);

		// Homing attack
		if (instance_exists(Reticle)) {
			player_set_state(player_state_homing);
			exit;
		} 
		
		// Homing dash
		else {
			allow_jump_action = false;
			hor_speed = 8 * image_xscale;
			ver_speed = 0;
		}
	}
}

function sonic_routine_homing() {
	// Create reticle
	if (!instance_exists(obj_reticle)) {
		if (allow_jump_action) {
			// Record targets
			var target_list = [
				instance_nearest(x, y, obj_spring),
				instance_nearest(x, y, obj_monitor),
				instance_nearest(x, y, obj_enemy), // Higher priority
			];

			// Evaluate all targets
			for (var i = array_length(target_list) - 1; i > -1; --i) {
				// Get the current target
				var focus = target_list[i];
				
				// Lock-on to it if possible
				if (focus != noone and focus.usable and player_can_lockon(focus)) {
					vfx_create(focus.x, focus.y, obj_reticle, { target: focus });
					exit;
				}
			}
		}
	}

	// Destroy reticle
	else if (!player_can_lockon(obj_reticle.target)) {
		instance_destroy(obj_reticle);
	}

	// Perform a homing action
	if (allow_jump_action and input_pressed(vb_a)) {
		// FX
		mixer_play_effect(data_dash.sfx, mixer_modes.swap);
		part_particles_create(global.particles, x, y, vfx_homing_burst, 1);
		rotation = gravity_direction;
		curl_ups++;
		player_set_trail_span(80);

		// Homing attack
		if (instance_exists(obj_reticle)) {
			player_set_state(player_state_homing);
		} 
		
		// Homing dash
		else {
			image_xscale = dir;
			allow_jump_action = false;
			hor_speed = 8 * dir;
			ver_speed = 0;
		}
	}
}

function player_land() {
	// Wait until the player has landed
	if (!is_grounded) {
		return;
	}

	// Is the player stomping?
	if (state == states.stomp) {
		// Update player parameters
		var strength = (is_underwater) ? (-4) : (-7.5);
		hor_speed = strength * dsin(angle);
		is_grounded = false;
		on_object = false;
		
		// Reset collision radiuses
		pos_y -= big_radius_y - radius_y;
		radius_x = big_radius_x;
		radius_y = big_radius_y;
		
		// Change state
		player_set_state(hor_speed == 0 ? states.crouch : states.move);

		// Effects
		screen_shake(25);
		audio_stop_sound(snd_player_stomp_start);
		audio_play_sfx(snd_player_stomp_end);
	} else {
		// Update player animation
		if (!on_object and state != states.idle and state != states.spindash) {
			player_set_state(states.move);
		}

		// Reset flags
		air_lock = false;
		is_dashing = false;
		is_jumping = false;
		is_pushing = false;
		is_rolling = false;
		
		// Reset flags when hurt
		if (is_being_hurt) {
			is_being_hurt = false;
			gnd_speed = 0;
		}

		// Update visual angle if floor is steep enough
		if (angle >= 35.16 and angle <= 324.84) {
			rotation = angle;
		}

		// Reset gravity
		grv = (is_underwater) ? (0.0625) : (0.21875);

		// Reset collision radiuses assuming the player isn't rolling or sliding
		pos_y -= big_radius_y - radius_y;
		radius_x = big_radius_x;
		radius_y = big_radius_y;
		
		// SFX
		if (!audio_is_playing(snd_player_stomp_end)) {
			var material = player_find_material();
			audio_play_sfx(snd_land[material]);
		}
	}
}

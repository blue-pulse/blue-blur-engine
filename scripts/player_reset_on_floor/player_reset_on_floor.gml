function player_reset_on_floor() {
	// Wait until the player has landed
	if !is_grounded {
		return;
	}

	// Is the player stomping?
	if (is_stomping) {
		// Update player parameters
		var force = (is_underwater) ? (-4) : (-7.5);
		hor_speed = force * dsin(angle);
		is_stomping = false;
		is_grounded = false;
		on_object = false;

		// FX
		shake_effect(25);
		audio_stop_sound(snd_player_stomp_start);
		audio_play_sfx(snd_player_stomp_end);
	} else {
		// Update player animation
		if (!on_object and state != states.idle and state != states.spindash) {
			state = states.moving;
		}

		// Reset flags
		air_lock = false;
		is_dashing = false;
		is_jumping = false;
		is_pushing = false;
		is_rolling = false;
		is_stomping = false;
		
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
		if (!is_underwater) {
			grv = 0.21875;
		} else {
			grv = 0.0625
		}

		// Reset collision radiuses if not rolling
		if (!is_rolling) {
			pos_y -= df_radius_y - radius_y;
			radius_x = df_radius_x;
			radius_y = df_radius_y;
		}
	}
}

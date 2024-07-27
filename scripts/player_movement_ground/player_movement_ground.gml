function player_movement_ground() {
	// Early exit
	if (spindash_revolutions != -1) {
		return;
	}

	if (!gnd_lock) {
		if (button_check("btn_left")) {
			// Decelerate
			if (gnd_speed > 0) {
				gnd_speed -= decel;
				if (gnd_speed <= 0) {
					gnd_speed = -0.5;
				}
			}

			// Accelerate
			else {
				if (dir != LEFT) {
					dir = LEFT;
					is_pushing = false;
					image_index = 0;
				}
				if (gnd_speed > -max_hor_speed) {
					gnd_speed = max(gnd_speed - accel, -max_hor_speed);
				}
			}
		}
		else if button_check("btn_right") {
			// Decelerate
			if gnd_speed < 0 {
				gnd_speed += decel;
				if (gnd_speed >= 0) {
					gnd_speed = 0.5;
				}
			}

			// Accelerate
			else {
				if (dir != RIGHT) {
					dir = RIGHT;
					is_pushing = false;
					image_index = 0;
				}
				if (gnd_speed < max_hor_speed) {
					gnd_speed = min(gnd_speed + accel, max_hor_speed);
				}
			}
		}

		// Perform skid. angle check here is different in comparison to collision mode checks
		if (state != states.skidding and (angle <= 45 or angle >= 316.41)) {
			if (button_check("btn_left") and gnd_speed >= 4 or button_check("btn_right") and gnd_speed <= -4) {
				state = states.skidding;
				audio_play_sfx(snd_player_skid, true);
			}
		}
	}

	// Apply friction
	if (!button_check("btn_left") and !button_check("btn_right")) {
		if (gnd_speed > 0) {
			gnd_speed = max(gnd_speed - frict, 0);
		} else {
			gnd_speed = min(gnd_speed + frict, 0);
		}
		is_pushing = false;
	}

	// Convert ground inertia to speed
	hor_speed = gnd_speed * dcos(angle);
	ver_speed = gnd_speed * -dsin(angle);

	// Set animation
	if (is_pushing) {
		state = states.pushing;
	} else if (gnd_speed == 0) {
		// Unsymmetrical angle check
		if (angle <= 45 or angle >= 316.41) {
			if (button_check("btn_up")) {
				state = states.searching;
			} else if (button_check("btn_down")) {
				state = states.crouching;
			} else {
				state = states.idle;
			}
		}
	} else {
		if (state != states.skidding) {
			state = states.moving;
		} else if (gnd_speed > 0 and button_check("btn_right") or gnd_speed < 0 and button_check("btn_left")) {
			state = states.moving;
		}
	}
}

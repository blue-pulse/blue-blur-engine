function player_boost_start() {
	// Variables
	static allow_boost = true;
	static air_boost_timer = 90;
	 
	// Stop boosting
	if is_boosting and (!button_check("btn_3") or stamina <= 0 or abs(hor_speed) < 1 or is_rolling or (air_boost_timer <= 0 and !is_grounded)) {
		is_boosting = false;
		allow_boost = false;
	}

	// Reduce time
	if is_boosting and !is_grounded {
		air_boost_timer -= 1;
	}

	// Check if the player is not colliding with a wall
	if (!is_pushing and stamina > 0) {

		if (is_jumping or state == states.idle or state == states.moving) {
			// Trigger boost dash
			if button_check_pressed("btn_3") and !is_boosting {
				allow_boost = true;
				audio_play_sfx(snd_player_boost_start);
				stamina -= 1.5;
				if abs(hor_speed) < max_hor_speed {
					gnd_speed = max_hor_speed * facing;
					hor_speed = gnd_speed * dcos(angle);
				}
			}

			// Keep boosting
			if (button_check("btn_3") and allow_boost) {
				is_boosting = true;
				stamina -= 0.25;
				if (!instance_exists(obj_boost_aura)) {
					instance_create_vfx(x, y, obj_boost_aura);
				}
			}
		}
	}
}

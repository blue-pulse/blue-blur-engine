function player_reaction_enemy(object) {
	// Take damage if not in an attacking state
	if (!is_rolling) {
		return player_receive_damage(object);
	}
	
	// Variables
	var points = 0;
	var change_state = false;
	
	// Rebound in the air
	if (state == player_state_homing) {
		// Stop moving and bounce
		player_set_state(player_state_airbone);
		change_state = true;
		
		// Variables
		hor_speed = 0;
		ver_speed = round(-jump_height);
	} else if (!is_grounded) {
		// Move down slightly
		if (ver_speed < 0 and collision_box_vertical(hor_radius, -ver_radius, mask_direction, object)) {
			ver_speed++;
		}
		
		// Bounce
		else if (ver_speed >= 0 and collision_box_vertical(hor_radius, ver_radius, mask_direction, object)) {
			ver_speed *= -1;
		}
	}
	
	// Scoring
	if (++score_combo > 15) {
		global.score += 10000;
		points = 5;
	} else if (score_combo > 3) {
		global.score += 1000;
		points = 4;
	} else if (score_combo > 2) {
		global.score += 500;
		points = 3;
	} else if (score_combo > 1) {
		global.score += 200;
		points = 2;
	} else {
		global.score += 100;
		points = 1;
	}

	// Display points
	vfx_create(object.x, object.y, obj_points, { index: points }, true);
	
	// Destroy badnik and reticle
	instance_destroy(obj_reticle);
	instance_destroy(object);
	
	// Abort state
	return change_state;
}

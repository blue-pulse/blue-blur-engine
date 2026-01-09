function player_reaction_badnik(object) {
	// Take damage if not in an attacking state
	if (!is_rolling) {
		return player_receive_damage(object);
	}
	
	// Variables
	var bonus = 100;
	var points = 1;
	var homing_rebound = false;
	
	// Rebound in the air
	if (state == player_state_homing) {
		// Stop moving and bounce
		player_set_state(player_state_airbone);
		hor_speed = 0;
		ver_speed = floor(-jump_height);
		homing_rebound = true;
	} else if (!is_grounded) {
		// Weigh down slightly
		if (ver_speed < 0 and collision_box_vertical(hor_radius, -ver_radius, mask_direction, object)) {
			++ver_speed;
		} 
		
		// Bounce
		else if (ver_speed >= 0 and collision_box_vertical(hor_radius, ver_radius, mask_direction, object)) {
			ver_speed *= -1;
		}
	}
	
	// Scoring
	if (++score_combo > 15) {
		bonus = 10000;
		points = 5;
	} else if (score_combo > 3) {
		bonus = 1000;
		points = 4;
	} else if (score_combo > 2) {
		bonus = 500;
		points = 3;
	} else if (score_combo > 1) {
		bonus = 200;
		points = 2;
	}

	global.score += bonus;
	vfx_create(object.x, object.y, obj_points, {
		index: points,
	}, true);
	
	// Destroy badnik and reticle
	instance_destroy(obj_reticle);
	instance_destroy(object);
	
	// Abort state if rebounded from a homing attack
	return homing_rebound;
}

function player_physics_update() {
	if (is_grounded) {
		if (is_rolling) {
			// Doing an action
			if player_jump_start() then return false;

			// Rolling
			player_slope_resist_roll();
			player_movement_roll();
			player_collision_wall();
		} else {
			// Doing an action
			if player_spindash_start() then return false;
			if player_jump_start() then return false;

			// Walking
			player_slope_resist();
			player_movement_ground();
			player_balance_update();
			player_collision_wall();
			player_roll_update();
			player_slide_update();
		}
		// Finally
		player_position_update();
		player_collision_floor();
		player_slope_repel();
	} else {
		// Airborne
		player_jump_update();
		player_movement_air();
		player_position_update();
		player_collision_air();
		player_reset_on_floor();
	}
}

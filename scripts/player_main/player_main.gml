function player_main() {
	if (is_grounded) {
		if (is_rolling) {
			// Doing an action
			if player_jump_start() then return false;

			// Rolling
			player_slope_resist_roll();
			player_movement_roll();
			player_collision_wall();
		} else if (state == states.sliding) {
			// Doing an action
			if player_jump_start() then return false;
			
			// Sliding
			player_slope_resist();
			player_movement_slide();
			player_collision_wall();
		} else {
			// Doing an action
			if player_spindash_start() then return false;
			if player_jump_start() then return false;

			// Walking
			player_slope_resist();
			player_movement_ground();
			player_balance();
			player_collision_wall();
			player_roll_start();
			player_slide_start();
		}
		// Finally
		player_update_position();
		player_collision_floor();
		player_slope_repel();
	} else {
		// Airborne
		player_jump();
		player_movement_air();
		player_update_position();
		player_collision_air();
		player_land();
	}
}

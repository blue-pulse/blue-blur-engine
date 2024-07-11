function player_handle_physics() {
	if (is_grounded) {
		if (is_rolling) {
			// Is spinning
			player_slope_resist_roll();	
			player_movement_roll();
			player_collision_wall();
		} else {
			// Is walking
			player_slope_resist();
			player_movement_ground();
			player_collision_wall();
		}
		// Finally
		player_handle_position();
		player_collision_floor();
		player_slope_repel();
		player_handle_hitbox();
	} else {
		// Is airborne
		player_movement_air();
		player_handle_position();
		player_collision_air();
		player_reset_on_floor();
		player_handle_hitbox();
	}
}
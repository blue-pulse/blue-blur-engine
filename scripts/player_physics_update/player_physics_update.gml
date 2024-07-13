function player_physics_update() {
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
			player_state_balancing();
			player_collision_wall();
		}
		// Finally
		player_position_update();
		player_collision_floor();
		player_slope_repel();
		player_hitbox_update();
	} else {
		// Is airborne
		player_movement_air();
		player_position_update();
		player_collision_air();
		player_reset_on_floor();
		player_hitbox_update();
	}
}
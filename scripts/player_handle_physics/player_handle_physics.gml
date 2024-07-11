function player_handle_physics() {
	if (is_grounded) {
		if (is_rolling) {
			// Is spinning
			//if (PlayerJumpStart()) then return;
			player_slope_resist_roll();	
			player_movement_roll();
			player_collision_wall();
		} else {
			// Is walking
			//if (PlayerSpindash()) then return;
			//if (PlayerJumpStart()) then return;
			player_slope_resist();
			player_movement_ground();
			//PlayerBalance();
			player_collision_wall();	
			//PlayerRollStart();	
		}
		// Finally
		player_handle_position();
		player_collision_floor();
		player_slope_repel();
		player_handle_hitbox();
	} else {
		// Is airborne
		//PlayerJump();
		player_movement_air();
		player_handle_position();
		player_collision_air();
		player_reset_on_floor();
		player_handle_hitbox();
	}
}
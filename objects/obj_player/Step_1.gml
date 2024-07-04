if (allow_movement) {
	if (is_grounded) {
		if (is_rolling) {
			// Is spinning
			if (PlayerJumpStart()) then return;
			player_slope_resist_roll();	
			PlayerMovementRoll();
			player_collision_wall();
		} else {
			// Is walking
			if (PlayerSpindash()) then return;
			if (PlayerJumpStart()) then return;
			player_slope_resist();
			PlayerMovementGround();
			PlayerBalance();
			player_collision_wall();	
			PlayerRollStart();	
		}
		// Finally
		player_handle_position();
		player_collision_floor();
		player_slope_repel();
		player_handle_hitbox();
	} else {
		// Is airborne
		PlayerJump();
		PlayerMovementAir();
		player_handle_position();
		player_collision_air();
		PlayerResetOnFloor();
		player_handle_hitbox();
	}
}
if (allow_movement) {
	if (is_grounded) {
		if (is_rolling) {
			// Is spinning
			if (PlayerJumpStart()) then return;
			player_slope_resist_roll();	
			PlayerMovementRoll();
			player_wall_collision();
		} else {
			// Is walking
			if (PlayerSpindash()) then return;
			if (PlayerJumpStart()) then return;
			player_slope_resist();
			PlayerMovementGround();
			PlayerBalance();
			player_wall_collision();	
			PlayerRollStart();	
		}
		// Finally
		player_handle_position();
		player_floor_collision();
		player_slope_repel();
		player_handle_hitbox();
	} else {
		// Is airborne
		PlayerJump();
		PlayerMovementAir();
		player_handle_position();
		player_air_collision();
		PlayerResetOnFloor();
		player_handle_hitbox();
	}
}
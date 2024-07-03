if (allow_movement) {
	if (is_grounded) {
		if (is_rolling) {
			// Is spinning
			if (PlayerJumpStart()) then return;
			PlayerSlopeResistRoll();	
			PlayerMovementRoll();
			player_wall_collision();
		} else {
			// Is walking
			if (PlayerSpindash()) then return;
			if (PlayerJumpStart()) then return;
			PlayerSlopeResist();
			PlayerMovementGround();
			PlayerBalance();
			player_wall_collision();	
			PlayerRollStart();	
		}
		// Finally
		player_handle_position();
		player_floor_collision();
		PlayerSlopeRepel();
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
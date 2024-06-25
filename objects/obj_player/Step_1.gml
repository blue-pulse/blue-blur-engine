	if PlayerProcess()
	{
		// Airborne
		if !Grounded
		{
			PlayerJump();
			PlayerMovementAir();
			PlayerPosition();
			PlayerAirLevelCollision();
			PlayerResetOnFloor();
			PlayerHitboxUpdate();
		}
		
		// Grounded
		else
		{
			if !Spinning
			{
				// Not rolling
				if PlayerSpindash()  return;
				if PlayerJumpStart() return;
				PlayerSlopeResist();
				PlayerMovementGround();
				PlayerBalance();
				PlayerGroundWallCollision();	
				PlayerRollStart();	
			}
			else
			{
				// Rolling
				if PlayerJumpStart() return;
				PlayerSlopeResistRoll();	
				PlayerMovementRoll();
				PlayerGroundWallCollision();
			}
			PlayerPosition();
			PlayerGroundFloorCollision();
			PlayerSlopeRepel();
			PlayerHitboxUpdate();
		}
	}	
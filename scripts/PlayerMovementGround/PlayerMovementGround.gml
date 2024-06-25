function PlayerMovementGround()
{	
	if SpindashRev != -1 or PeeloutRev != -1
	{
		return;
	}
	
	if !GroundLock 
	{
		if input_check("btn_left")
		{	
			// Decelerate
			if Gsp > 0 
			{
				Gsp -= Dec;
				if Gsp <= 0
				{
					Gsp = -0.5;
				}
			} 
			
			// Accelerate
			else
			{
				if Facing != FlipLeft
				{
					Facing  = FlipLeft;
					Pushing = false;
				}
				if global.GroundSpeedcap or Gsp > -TopAcc
				{
					Gsp = max(Gsp - Acc, -TopAcc);
				} 
			}
		}
		else if input_check("btn_right")
		{			
			// Decelerate
			if Gsp < 0 
			{
				Gsp += Dec;
				if Gsp >= 0
				{
					Gsp = 0.5;
				}
			} 
			
			// Accelerate
			else
			{
				if Facing != FlipRight
				{
					Facing  = FlipRight;
					Pushing = false;
				}
				if global.GroundSpeedcap or Gsp < TopAcc
				{
					Gsp = min(Gsp + Acc, TopAcc);
				} 
			}
		}
		
		// Perform skid. Angle check here is different in comparison to collision mode checks
		if (Angle <= 45 or Angle >= 316.41) and Animation != AnimSkid
		{
			if input_check("btn_left") and Gsp >= 4 or input_check("btn_right") and Gsp <= -4
			{
				Animation = AnimSkid;
			}
		}
	}
	
	// Apply friction
	if !input_check("btn_left") and !input_check("btn_right")
	{
		if Gsp > 0
		{
			Gsp = max(Gsp - Frc, 0);
		}
		else
		{
			Gsp = min(Gsp + Frc, 0);
		}
		Pushing = false;
	}

	// Convert ground inertia to speed
	Xsp = Gsp *  dcos(Angle);
	Ysp = Gsp * -dsin(Angle);
	
	// Define which animations should be in priority over the idle animation
	switch Animation
	{
		case AnimDropStand:
		case AnimGlideStand:
			var AnimationPriority = true;
		break;
		default:
			var AnimationPriority = false;
	}
	
	// Set animation
	if Pushing
	{
		Animation = AnimPush;
	}
	else if Gsp == 0
	{
		// Same unsymmetrical angle check, just like above...
		if (Angle <= 45 or Angle >= 316.41) and !AnimationPriority
		{
			if input_check("btn_up")
			{
				Animation = AnimLookup;
			}
			else if input_check("btn_down")
			{
				Animation = AnimCrouch;
			}
			else
			{
				Animation = AnimIdle;
			}
		}
	}
	else
	{
		if Animation != AnimSkid
		{
			Animation = AnimMove;
		}
		else if Gsp > 0 and input_check("btn_right") or Gsp < 0 and input_check("btn_left")
		{
			Animation = AnimMove;
		}
	}
}
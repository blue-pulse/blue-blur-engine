/*
/// @description Process Camera
// You can write your code in this editor

	#region Process Follow
	{
		if Enabled and instance_exists(Target)
		{
			// Get target's position relative to camera
			if Target == Player
			{
				if Player.is_rolling 
				{
					var Offset = Player.big_radius_y - Player.radius_y;
				}
				else
				{
					var Offset = 0;
				}
				TargetX = floor(Player.pos_x) - PosX;
				TargetY = floor(Player.pos_y) - PosY - Offset;
			}
			else
			{
				TargetX = Target.x - PosX;
				TargetY = Target.y - PosY;
			}
	
			// Set horizontal shift speed
			if TargetX <= WIDTH / 2 - 16 
			{ 
				ShiftX = clamp(TargetX - (WIDTH / 2 - 16), -MaxShiftX, 0);  
			}
			else if TargetX >= WIDTH / 2
			{ 
				ShiftX = clamp(TargetX - (WIDTH / 2), 0, MaxShiftX);    
			}
			else
			{
				ShiftX = 0;
			}
	
			// Set vertical shift speed
			if Target == Player and Player.is_grounded
			{	
				if abs(Player.gnd_speed) >= 8
				{
					var Limit = MaxShiftY;
				}
				else
				{
					var Limit = 6;
				}
				ShiftY = clamp(TargetY - (HEIGHT / 2 - 16), -Limit, Limit);
			} 
			else 
			{
				if TargetY <= HEIGHT / 2 - 48 
				{ 
					ShiftY = clamp(TargetY - (HEIGHT / 2 - 48), -MaxShiftY, 0);  
				} 
				else if TargetY >= HEIGHT / 2 + 16 
				{ 
					ShiftY = clamp(TargetY - (HEIGHT / 2 + 16), 0, MaxShiftY);  
				}
				else
				{
					ShiftY = 0;
				}
			}
	
			// Follow target
			if ScrollDelay
			{
				ScrollDelay--;
			}
			else
			{
				PosX += ShiftX;		
			}
			PosY += ShiftY;
		}
	}
	#endregion
	
	#region Update Offsets
	{
		// Shake the camera. Not quite accurate to originals, but somewhat close (we hope)
		if ShakeTime
		{
			ShakeX     = irandom_range(8, 15)    * choose(-1, 1) * (1 + ShakeTime / 6) / 128;
			ShakeY     = irandom_range(128, 255) * choose(-1, 1) * (1 + ShakeTime / 6) / 255;
			ShakeTime -= 1;
		}
		else
		{
			ShakeX = 0;
			ShakeY = 0;
		}
		
		if Enabled and instance_exists(Target) and Target == Player
		{
			// Offset camera horizontally, like in CD
			if true
			{
				var ScreenShift	= 64;	// <- default value for 320px width, which is floor(WIDTH / 5)
		
				var ScreenSpeed    = floor(ScreenShift / 32);
				var ShiftDirection = Player.gnd_speed != 0 ? sign(Player.gnd_speed) : Player.dir;
		
				if abs(Player.gnd_speed) >= 6 or Player.state == states.spindash
				{
					if !ScrollDelay and ExtendedOffset != ScreenShift * ShiftDirection
					{
						ExtendedOffset += ScreenSpeed * ShiftDirection
					}
				}
				else
				{
					ExtendedOffset -= ScreenSpeed * sign(ExtendedOffset);
				}
			}
	
			// Check for overview delay
			var ShiftDown = Player.state == states.crouch;
			var ShiftUp   = Player.state == states.search;
	
			if (ShiftUp or ShiftDown)
			{
				if OverviewDelay
				{
					OverviewDelay--;
				}
			}
			else
			{
				OverviewDelay = 120;
			}
	
			// Offset vertically
			if (ShiftUp or ShiftDown) and !OverviewDelay
			{
				if ShiftDown and OverviewOffset < 88 
				{
					OverviewOffset += 2;
				}
				if ShiftUp and OverviewOffset > -104 
				{
					OverviewOffset -= 2;
				} 	
			} 
			else if OverviewOffset != 0
			{
				OverviewOffset -= 2 * sign(OverviewOffset);
			}
		}
	}
	#endregion
	
	#region Position Update
	{
		// Calculate final view position
		if true
		{
			ViewX = clamp(PosX + ExtendedOffset, 0, room_width  - WIDTH);
			ViewY = clamp(PosY + OverviewOffset, 0, room_height - HEIGHT);
		}
		else
		{
			ViewX = PosX;
			ViewY = PosY;
		}
		ViewX += ShakeX;
		ViewY += ShakeY;
	
		// Update camera position
		camera_set_view_pos(view, ViewX - BUFFER, ViewY);
	}
	#endregion
*/
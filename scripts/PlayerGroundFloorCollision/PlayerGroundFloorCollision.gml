function PlayerGroundFloorCollision()
{	
	if !allow_collision or OnObject
	{
		return;
	}
	
	// Update collision mode
	#region Code
	{
		/* Originals method, get current angle quadrant */

		if !global.BetterPlayerTileGrip
		{
			if angle <= 45 or angle >= 315
			{
				collision_mode[0] = 0;
			}
			else if angle >= 46.41 and angle <= 133.59
			{
				collision_mode[0] = 1;
			}
			else if angle >= 135 and angle <= 225
			{
				collision_mode[0] = 2;
			}
			else if angle >= 226.41 and angle <= 313.59
			{
				collision_mode[0] = 3;
			}
		}
	
		/* Custom method, check for slopes. Provides better stability on convex ones */
		
		else if !collision_mode[1]
		{
			// If the difference between found angle and current angle is greater than this, collision mode won't update
			var AngleTolerance = 45;
			
			switch collision_mode[0]
			{
				// Floor mode
				case 0:
				{
					// Switch to right wall mode
					var FindTile = tile_find_h(pos_x + radius_y - 2, pos_y + radius_x, true, plane);
					if  FindTile[0] < 0
					{
						if FindTile[1] - angle mod 360 < AngleTolerance
						{
							collision_mode[0] = 1;
						}
					}
					
					// Switch to left wall mode
					var FindTile = tile_find_h(pos_x - radius_y + 2, pos_y + radius_x, false, plane);
					if  FindTile[0] < 0
					{
						if angle - FindTile[1] < AngleTolerance
						{
							collision_mode[0] = 3;
						}
					}
				}
				break;
				
				// Right wall mode
				case 1:	
				{
					// Switch to floor mode
					var FindTile = tile_find_v(pos_x + radius_x, pos_y + radius_y - 2, true, plane);
					if  FindTile[0] < 0
					{
						if angle - FindTile[1] mod 360 < AngleTolerance
						{
							collision_mode[0] = 0;
						}
					}
					
					// Switch to ceiling mode
					var FindTile = tile_find_v(pos_x + radius_x, pos_y - radius_y + 2, false, plane);
					if  FindTile[0] < 0
					{
						if FindTile[1] - angle < AngleTolerance
						{
							collision_mode[0] = 2;
						}
					}
				}
				break;
				
				// Ceiling mode
				case 2:
				{
					// Switch to right wall mode
					var FindTile = tile_find_h(pos_x + radius_y - 2, pos_y - radius_x, true, plane);
					if  FindTile[0] < 0
					{
						if angle - FindTile[1] < AngleTolerance
						{
							collision_mode[0] = 1;
						}
					}
					
					// Switch to left wall mode
					var FindTile = tile_find_h(pos_x - radius_y + 2, pos_y - radius_x, false, plane);
					if  FindTile[0] < 0
					{
						if FindTile[1] - angle < AngleTolerance
						{
							collision_mode[0] = 3;
						}
					}
				}
				break;
				
				// Left wall mode
				case 3:
				{
					// Switch to floor mode
					var FindTile = tile_find_v(pos_x - radius_x, pos_y + radius_y - 2, true, plane);
					if  FindTile[0] < 0
					{
						if FindTile[1] - angle < AngleTolerance
						{
							collision_mode[0] = 0;
						}
					}
					
					// Switch to ceiling mode
					var FindTile = tile_find_v(pos_x - radius_x, pos_y - radius_y + 2, false, plane);
					if  FindTile[0] < 0
					{
						if angle - FindTile[1] < AngleTolerance
						{
							collision_mode[0] = 2;
						}
					}
				}
				break;
			}
		}
		else
		{
			// Reset landing flag
			collision_mode[1] = false;
		}
	}
	#endregion
	
	// Perform collision based on current collision mode
	switch collision_mode[0]
	{
		// Floor mode
		case 0:
		{		
			// Get tile below us
			var FindFloor = tile_find_2v(pos_x - radius_x, pos_y + radius_y, pos_x + radius_x, pos_y + radius_y, true, angle, plane);
			
			// Go airborne if surface is too far away from us
			if !stick_to_convex
			{
				var Distance = (!global.S2FloorCollision) ? (14) : (min(4 + abs(floor(horizontal_speed)), 14));
				if  FindFloor[0] > Distance
				{
					if state == states.moving
					{
						//animation_reset(0);
					}
					is_pushing  = false;
					is_grounded = false;
					
					break;
				}		
			}
			
			// Else collide
			if FindFloor[0] >= -14
			{
				pos_y += FindFloor[0];
				angle = FindFloor[1];	
			}
		}
		break;
		
		// Right wall mode
		case 1:
		{	
			// Get tile to our right
			var FindFloor = tile_find_2h(pos_x + radius_y, pos_y + radius_x, pos_x + radius_y, pos_y - radius_x, true, angle, plane);
			
			// Go airborne if surface is too far away from us
			if !stick_to_convex
			{
				var Distance = (!global.S2FloorCollision) ? (14) : (min(4 + abs(floor(vertical_speed)), 14));
				if  FindFloor[0] > Distance
				{
					if state == states.moving
					{
						//animation_reset(0);
					}
					is_pushing  = false;
					is_grounded = false;
					
					break;
				}	
			}
			
			// Else collide
			if FindFloor[0] >= -14
			{
				pos_x += FindFloor[0];
				angle = FindFloor[1];	
			}
		}
		break;
		
		// Ceiling mode
		case 2:	
		{	
			// Get tile above us
			var FindFloor = tile_find_2v(pos_x + radius_x, pos_y - radius_y, pos_x - radius_x, pos_y - radius_y, false, angle, plane);
			
			// Go airborne if surface is too far away from us
			if !stick_to_convex
			{
				var Distance = (!global.S2FloorCollision) ? (14) : (min(4 + abs(floor(horizontal_speed)), 14));
				if  FindFloor[0] > Distance
				{
					if state == states.moving
					{
						//animation_reset(0);
					}
					is_pushing  = false;
					is_grounded = false;
					
					break;
				}
			}
			
			// Else collide
			if FindFloor[0] >= -14
			{	
				pos_y -= FindFloor[0];
				angle = FindFloor[1];
			}
		}
		break;
		
		// Left wall mode
		case 3:
		{	
			// Get tile to our left
			var FindFloor = tile_find_2h(pos_x - radius_y, pos_y - radius_x, pos_x - radius_y, pos_y + radius_x, false, angle, plane); 
			
			// Go airborne if surface is too far away from us
			if !stick_to_convex
			{
				var Distance = (!global.S2FloorCollision) ? (14) : (min(4 + abs(floor(vertical_speed)), 14));
				if  FindFloor[0] > Distance
				{
					if state == states.moving
					{
						//animation_reset(0);
					}
					is_pushing  = false;
					is_grounded = false;
					
					break;
				}
			}
				
			// Else collide
		    if FindFloor[0] >= -14
			{
				pos_x -= FindFloor[0];
				angle = FindFloor[1];
			}
		}
		break;
	}
}
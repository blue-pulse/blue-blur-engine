function PlayerGroundWallCollision()
{	
	if !allow_collision
	{
		return;
	}
	
	// Unsymmetric check here!
	if angle >= 91.41 and angle <= 270
	{
		if !global.SKWallCollision or angle mod 90 != 0
		{
			return;
		}
	}
	
	var YOffset = 8 * (angle == 360);
	var WRadius = default_radius_x + 1;
	
	/* Get current angle quadrant, different from the one used for collision_mode to define the check direction. 
	The game still uses collision_mode angle ranges to decide to which side player should be pushed to */
	
	if angle <= 43.59 or angle >= 316.41			
	{
		var DirectionCheck = 0;
	}
	else if angle >= 45 and angle <= 135	
	{
		var DirectionCheck = 1;
	}
	else if angle >= 136.41 and angle <= 223.59
	{
		var DirectionCheck = 2;
	}
	else if angle >= 225 and angle <= 315	
	{
		var DirectionCheck = 3;
	}

	// Left wall collision
	if ground_speed < 0
	{
		// Check for the wall to our left, frame ahead
		switch DirectionCheck
		{
			case 0:
				var FindWall = tile_find_h(pos_x + horizontal_speed - WRadius, pos_y + vertical_speed + YOffset, false, plane)[0];
			break;
			case 1:
				var FindWall = tile_find_v(pos_x + horizontal_speed, pos_y + vertical_speed + WRadius, true, plane)[0];
			break;
			case 2:
				var FindWall = tile_find_h(pos_x + horizontal_speed + WRadius, pos_y + vertical_speed, true, plane)[0];
			break;
			case 3:
				var FindWall = tile_find_v(pos_x + horizontal_speed, pos_y + vertical_speed - WRadius, false, plane)[0];
			break;
		}
		
		// Collide with it
		if FindWall < 0 then switch collision_mode[0]
		{
			case 0:
			{
				horizontal_speed -= FindWall;
				ground_speed  = 0;
					
				// Set pushing flag
				if facing == left and !is_rolling
				{
					is_pushing = true;
				}
			}
			break;
			case 1:
			{
				vertical_speed += FindWall;
			}
			break;
			case 2:
			{
				horizontal_speed += FindWall;
				ground_speed  = 0;
					
				// Set pushing flag
				if facing == left and !is_rolling
				{
					is_pushing = true;
				}
			}
			break;
			case 3:
			{
				vertical_speed -= FindWall;
			}
			break;
		}
	}
	
	// Right wall collision
	else if ground_speed > 0
	{
		// Check for the wall to our right, frame ahead
		switch DirectionCheck
		{
			case 0:
				var FindWall = tile_find_h(pos_x + horizontal_speed + WRadius, pos_y + vertical_speed + YOffset, true, plane)[0];
			break;
			case 1:
				var FindWall = tile_find_v(pos_x + horizontal_speed, pos_y + vertical_speed - WRadius, false, plane)[0];
			break;
			case 2:	
				var FindWall = tile_find_h(pos_x + horizontal_speed - WRadius, pos_y + vertical_speed, false, plane)[0];
			break;
			case 3:
				var FindWall = tile_find_v(pos_x + horizontal_speed, pos_y + vertical_speed + WRadius, true, plane)[0];
			break;
		}
		
		// Collide with it
		if FindWall < 0 then switch collision_mode[0]
		{
			case 0:
			{
				horizontal_speed += FindWall;
				ground_speed  = 0;
					
				// Set pushing flag
				if facing == right and !is_rolling
				{
					is_pushing = true;
				}
			}
			break;
			case 1:
			{
				vertical_speed -= FindWall;
			}
			break;
			case 2:
			{
				horizontal_speed -= FindWall;
				ground_speed  = 0;
				
				// Set pushing flag
				if facing == right and !is_rolling
				{
					is_pushing = true;
				}
			}
			break;
			case 3:
			{
				vertical_speed += FindWall;
			}
			break;
		}
	}
}
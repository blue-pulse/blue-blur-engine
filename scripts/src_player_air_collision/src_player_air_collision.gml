function handle_player_air_collision() {
	if !allow_collision {
		return;
	}
	
	var WRadius = default_radius[0] + 1;
	
	// Define direction of our movement
	if abs(horizontal_speed) >= abs(vertical_speed)
	{
		var MoveDirection = horizontal_speed > 0 ? "MoveRight" : "MoveLeft";
	}
	else
	{
		var MoveDirection = vertical_speed > 0 ? "MoveDown" : "MoveUp";
	}
	
	// Process collision
	switch MoveDirection
	{
		case "MoveDown":
		{
			// Collide with left wall
			var FindWall = tile_find_h(pos_x - WRadius, pos_y, false, current_layer)[0];
			if  FindWall < 0
			{
				pos_x -= FindWall;
				horizontal_speed   = 0;
			}
			
			// Collide with right wall
			var FindWall = tile_find_h(pos_x + WRadius, pos_y, true, current_layer)[0];
			if  FindWall < 0
			{
				pos_x += FindWall;
				horizontal_speed   = 0;
			}
			
			// Collide with floor. We have to remember both distances, so we do not use tile_find_2v here
			var FindFloor1 = tile_find_v(pos_x - radius_x, pos_y + radius_y, true, current_layer);
			var FindFloor2 = tile_find_v(pos_x + radius_x, pos_y + radius_y, true, current_layer);
			
			if FindFloor1[0] <= FindFloor2[0]
			{
				var Dist = FindFloor1[0];
				var Ang	 = FindFloor1[1];
			}
			else
			{
				var Dist = FindFloor2[0];
				var Ang	 = FindFloor2[1];
			}
			var ClipCheck = -(vertical_speed + 8)
			
			if Dist < 0 and (FindFloor1[0] >= ClipCheck or FindFloor2[0] >= ClipCheck)
			{
				if Ang >= 46.41 and Ang <= 315
				{
					if vertical_speed > 15.75
					{
						vertical_speed = 15.75;
					}
					horizontal_speed = 0;
					ground_speed = Ang < 180 ? -vertical_speed : vertical_speed;
				}
				else if Ang >= 23.91 and Ang <= 337.5
				{
					ground_speed = Ang < 180 ? -vertical_speed / 2 : vertical_speed / 2;
				}
				else 
				{	
					vertical_speed = 0;
					ground_speed = horizontal_speed;	
				}
					
				// Adhere to the surface and land
				pos_y    += Dist;
				angle    = Ang;
				is_grounded = true;
			}
		}
		break;	
		case "MoveUp":
		{
			// Collide with left wall
			var FindWall = tile_find_h(pos_x - WRadius, pos_y, false, current_layer)[0];
			if  FindWall < 0
			{
				pos_x -= FindWall;
				horizontal_speed   = 0;
			}
			
			// Collide with right wall
			var FindWall = tile_find_h(pos_x + WRadius, pos_y, true, current_layer)[0];
			if  FindWall < 0
			{
				pos_x += FindWall;
				horizontal_speed   = 0;
			}
			
			// Collide with ceiling
			var FindRoof = tile_find_closest(pos_x - radius_x, pos_y - radius_y, pos_x + radius_x, pos_y - radius_y, false, noone, current_layer, tile_find_v);
			if  FindRoof[0] < 0
			{	
				if (FindRoof[1] >= 91.41  and FindRoof[1] <= 136.41 
				or  FindRoof[1] >= 226.41 and FindRoof[1] <= 268.59)
				{
					// Land on it if its angle steep enough
					angle    = FindRoof[1];
					ground_speed      = FindRoof[1] < 180 ? -vertical_speed : vertical_speed;
					is_grounded = true;
				}
				else 
				{
					vertical_speed = 0;
				}				
				pos_y -= FindRoof[0];
			}
		}
		break;		
		case "MoveLeft":
		{
			// Collide with left wall
			var FindWall = tile_find_h(pos_x - WRadius, pos_y, false, current_layer)[0];
			if  FindWall < 0
			{
				pos_x -= FindWall;
				ground_speed   = vertical_speed;
				horizontal_speed   = 0;
			}
			else
			{
				// Collide with ceiling
				var FindRoof = tile_find_closest(pos_x - radius_x, pos_y - radius_y, pos_x + radius_x, pos_y - radius_y, false, noone, current_layer, tile_find_v);
				if  FindRoof[0] < 0
				{	
					if vertical_speed < 0
					{
						vertical_speed = 0;
					}
					pos_y -= FindRoof[0];
				}
				else if vertical_speed > 0
				{
					// Collide with floor
					var FindFloor = tile_find_closest(pos_x - radius_x, pos_y + radius_y, pos_x + radius_x, pos_y + radius_y, true, noone, current_layer, tile_find_v);
					if  FindFloor[0] < 0
					{
						pos_y	+= FindFloor[0];
						angle    = FindFloor[1];
						ground_speed		 = horizontal_speed;
						vertical_speed      = 0;
						is_grounded = true;
					}
				}
			}
		}
		break;
		case "MoveRight":
		{
			// Collide with right wall
			var FindWall = tile_find_h(pos_x + WRadius, pos_y, true, current_layer)[0];
			if  FindWall < 0
			{
				pos_x += FindWall;
				ground_speed   = vertical_speed;
				horizontal_speed   = 0;	
			}
			else
			{
				// Collide with ceiling
				var FindRoof = tile_find_closest(pos_x - radius_x, pos_y - radius_y, pos_x + radius_x, pos_y - radius_y, false, noone, current_layer, tile_find_v);
				if  FindRoof[0] < 0
				{	
					if vertical_speed < 0
					{
						vertical_speed = 0;
					}
					pos_y -= FindRoof[0];
				}
				else if vertical_speed > 0
				{
					// Collide with floor
					var FindFloor = tile_find_closest(pos_x - radius_x, pos_y + radius_y, pos_x + radius_x, pos_y + radius_y, true, noone, current_layer, tile_find_v);
					if  FindFloor[0] < 0
					{
						pos_y	+= FindFloor[0];
						angle    = FindFloor[1];
						ground_speed		 = horizontal_speed
						vertical_speed      = 0;
						is_grounded = true;
					}
				}
			}
		}
		break;
	}
	
	// If landed, update floor mode if using the custom method
	if is_grounded
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
		
		// This will disable floor mode check for one frame, allowing us to land on the ceilings safely
		collision_mode[1] = true;
	}
}
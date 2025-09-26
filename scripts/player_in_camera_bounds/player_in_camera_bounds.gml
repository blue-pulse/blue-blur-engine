function player_in_camera_bounds() {
	// Check if already within bounds (early out)
	if (mask_direction mod 180 != 0)
	{
		var x1 = x - ver_radius;
		var y1 = y - hor_radius;
		var x2 = x + ver_radius;
		var y2 = y + hor_radius;
	}
	else
	{
		var x1 = x - hor_radius;
		var y1 = y - ver_radius;
		var x2 = x + hor_radius;
		var y2 = y + ver_radius;
	}
	
	if (rectangle_in_rectangle(x1, y1, x2, y2, camera.bound_left, camera.bound_top, camera.bound_right, camera.bound_bottom) == 1)
	{
		return true;
	}
	
	// Move the player back within bounds according to their rotation
	switch (mask_direction)
	{
		// Down
		case 0:
		{
			if (x1 < camera.bound_left)
			{
				x = camera.bound_left + hor_radius;
				if (hor_speed < 0) hor_speed = 0;
			}
			if (x2 > camera.bound_right)
			{
				x = camera.bound_right - hor_radius;
				if (hor_speed > 0) hor_speed = 0;
			}
			if (y2 + ver_radius < camera.bound_top)
			{
				y = camera.bound_top - ver_radius * 2;
			}
			if (y1 > camera.bound_bottom)
			{
				// Out of bounds
				y = camera.bound_bottom + ver_radius;
				return false;
			}
			break;
		}
		
		// Right
		case 90:
		{
			if (y1 < camera.bound_top)
			{
				y = camera.bound_top + hor_radius;
				if (hor_speed > 0) hor_speed = 0;
			}
			if (y2 > camera.bound_bottom)
			{
				y = camera.bound_bottom - hor_radius;
				if (hor_speed < 0) hor_speed = 0;
			}
			if (x2 + ver_radius < camera.bound_left)
			{
				x = camera.bound_left - ver_radius * 2;
			}
			if (x1 > camera.bound_right)
			{
				x = camera.bound_right + ver_radius;
				return false;
			}
			break;
		}
		
		// Up
		case 180:
		{
			if (x1 < camera.bound_left)
			{
				x = camera.bound_left + hor_radius;
				if (hor_speed > 0) hor_speed = 0;
			}
			if (x2 > camera.bound_right)
			{
				x = camera.bound_right - hor_radius;
				if (hor_speed < 0) hor_speed = 0;
			}
			if (y1 - ver_radius > camera.bound_bottom)
			{
				y = camera.bound_bottom + ver_radius * 2;
			}
			if (y2 < camera.bound_top)
			{
				y = camera.bound_top - ver_radius;
				return false;
			}
			break;
		}
		
		// Left
		case 270:
		{
			if (y1 < camera.bound_top)
			{
				y = camera.bound_top + hor_radius;
				if (hor_speed < 0) hor_speed = 0;
			}
			if (y2 > camera.bound_bottom)
			{
				y = camera.bound_bottom - hor_radius;
				if (hor_speed > 0) hor_speed = 0;
			}
			if (x1 - ver_radius > camera.bound_right)
			{
				x = camera.bound_right + ver_radius * 2;
			}
			if (x2 < camera.bound_left)
			{
				x = camera.bound_left - ver_radius;
				return false;
			}
			break;
		}
	}
	
	// Player is back within bounds
	return true;
}

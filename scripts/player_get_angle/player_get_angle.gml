function player_get_angle(obj, rot)
{
	// Get the solid's collision and image data
	with (obj)
	{
		var kind = shape;
		var normal = surface_angle;
		var xscale = sign(image_xscale);
		var yscale = sign(image_yscale);
		var left_side = bbox_left;
		var right_side = bbox_right + 1;
		var top_side = bbox_top;
		var bottom_side = bbox_bottom + 1;
	}
	
	// Custom shape
	if (kind == SHP_CUSTOM)
	{
		// Initialize sensors
		var x_int = x div 1;
		var y_int = y div 1;
		var sine = dsin(rot);
		var cosine = dcos(rot);
		
		var x1 = x_int - (cosine * hor_radius) + (sine * ver_radius);
		var y1 = y_int + (sine * hor_radius) + (cosine * ver_radius);
		var x2 = x_int + (cosine * hor_radius) + (sine * ver_radius);
		var y2 = y_int - (sine * hor_radius) + (cosine * ver_radius);
		
		var left = false;
		var right = false;
		
		// Scan below feet
		repeat (ver_radius)
		{
			// Evaluate all solids
			for (var n = array_length(terrain_list) - 1; n > -1; --n)
			{
				// Get the current solid
				var inst = terrain_list[n];
				
				// Check if the sensors have found the solid
				if (not left and collision_point(x1, y1, inst, true, false) != noone)
				{
					left = true;
				}
				if (not right and collision_point(x2, y2, inst, true, false) != noone)
				{
					right = true;
				}
				
				// Calculate the direction from left to right
				if (left and right) return (point_direction(x1, y1, x2, y2) div 1);
			}
			
			// Push the sensors down
			if (not left)
			{
				x1 += sine;
				y1 += cosine;
			}
			if (not right)
			{
				x2 += sine;
				y2 += cosine;
			}
		}
		
		/* AUTHOR NOTE: the height at which the sensors are pushed down is dependent on that used to record instances local to the player.
		Currently, the maximum height sits at double the player's vertical radius.
		If you want to increase the height at which the sensors are pushed down, you must make sure it matches that in the `player_get_stage_objects` function. */
	}
	else if (not (kind == SHP_RECTANGLE and normal == -1))
	{
		// Default if on a flat side of the solid
		if ((rot == 0 and yscale == -1) or (rot == 90 and xscale == -1) or
			(rot == 180 and yscale == 1) or (rot == 270 and xscale == 1))
		{
			return rot;
		}
		
		// Default if out of the solid's bounds
		if (rot mod 180 != 0)
		{
			if ((yscale == -1 and y - hor_radius < top_side) or (yscale == 1 and y + hor_radius > bottom_side))
			{
				return rot;
			}
		}
		else
		{
			if ((xscale == -1 and x - hor_radius < left_side) or (xscale == 1 and x + hor_radius > right_side))
			{
				return rot;
			}
		}
		
		// If the solid's angle is hard-coded, return it
		if (normal != -1) return normal;
		
		// Determine calculation method
		if (kind == SHP_RIGHT_TRIANGLE)
		{
			// Get triangle dimensions
			var x1 = left_side;
			var y1 = bottom_side;
			var x2 = right_side;
			var y2 = top_side;
			
			if (yscale == -1)
			{
				x1 = right_side;
				x2 = left_side;
			}
			if (xscale == -1)
			{
				y1 = top_side;
				y2 = bottom_side;
			}
			
			// Calculate the angle of the hypotenuse
			return (point_direction(x1, y1, x2, y2) div 1);
		}
		else
		{
			// Get ellipse center and player position
			var cx = (kind == SHP_QUARTER_ELLIPSE xor xscale == 1) ? left_side : right_side;
			var cy = (kind == SHP_QUARTER_ELLIPSE xor yscale == 1) ? top_side : bottom_side;
			var px = clamp(x, left_side, right_side);
			var py = clamp(y, top_side, bottom_side);
			
			// Calculate the direction from the player to the ellipse center
			var dir = (kind == SHP_QUARTER_ELLIPSE) ? point_direction(px, py, cx, cy) : point_direction(cx, cy, px, py);
			return (((dir div 1) + 90) mod 360);
		}
	}
	
	// Failure
	return rot;
}

/// @description Calculates the surface angle of the given solid using its collision and image data.
/// @param {Id.Instance} obj Object or instance to check.
/// @param {Real} rot Base rotation to default to.
/// @returns {Real} The angle of the solid, or the base rotation on failure.
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
		
		var x1 = x_int - (cosine * x_radius) + (sine * y_radius);
		var y1 = y_int + (sine * x_radius) + (cosine * y_radius);
		var x2 = x_int + (cosine * x_radius) + (sine * y_radius);
		var y2 = y_int - (sine * x_radius) + (cosine * y_radius);
		
		var left = false;
		var right = false;
		
		// Scan below feet
		repeat (y_radius)
		{
			// Evaluate all solids
			for (var n = array_length(solid_objects) - 1; n > -1; --n)
			{
				// Get the current solid
				var inst = solid_objects[n];
				
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
			if ((yscale == -1 and y - x_radius < top_side) or (yscale == 1 and y + x_radius > bottom_side))
			{
				return rot;
			}
		}
		else
		{
			if ((xscale == -1 and x - x_radius < left_side) or (xscale == 1 and x + x_radius > right_side))
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

/// @description Finds and records any stage objects intersecting a bounding rectangle centered on the player.
function player_get_stage_objects()
{
	// Erase recorded objects
	array_resize(soft_objects, 0);
	array_resize(solid_objects, 0);
	
	// Initialize bounding rectangle
	var x_int = x div 1;
	var y_int = y div 1;
	var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	
	var x1 = x_int - (cosine * x_wall_radius * 2) - (sine * y_radius * 2);
	var y1 = y_int + (sine * x_wall_radius * 2) - (cosine * y_radius * 2);
	var x2 = x_int + (cosine * x_wall_radius * 2) + (sine * y_radius * 2);
	var y2 = y_int - (sine * x_wall_radius * 2) + (cosine * y_radius * 2);
	
	// Evaluate all stage objects
	with (objDeactivable)
	{
		// Continue if not intersecting the bounding rectangle
		if (collision_rectangle(x1, y1, x2, y2, id, true, false) == noone) continue;
		
		// Sort based on solidity, or lack thereof
		if (not object_is_ancestor(object_index, objSolid))
		{
			// Continue if no reaction exists
			if (reaction_index == -1) continue;
			array_push(other.soft_objects, id);
		}
		else
		{
			// Continue on collision layer mismatch
			if (collision_layer != -1 and collision_layer != other.collision_layer) continue;
			array_push(other.solid_objects, id);
		}
	}
}

/// @description Finds the direction of the nearest cliff from the player's position.
function player_find_cliff()
{
	// Reset cliff direction
	cliff_sign = 0;
	
	// Initialize
	var left = false;
	var right = false;
	var height = y_radius * 2;
	
	// Evaluate all solids
	for (var n = array_length(solid_objects) - 1; n > -1; --n)
	{
		// Get the current solid
		var inst = solid_objects[n];
		
		// Check sensors
		if (collision_ray_vertical(0, height, mask_direction, inst) != noone)
		{
			// Center collision means not on a cliff
			exit;
		}
		if (not left and collision_ray_vertical(-x_radius, height, mask_direction, inst) != noone)
		{
			left = true;
		}
		if (not right and collision_ray_vertical(x_radius, height, mask_direction, inst) != noone)
		{
			right = true;
		}
	}
	
	// Check if only one edge is touching
	if (left xor right) cliff_sign = left - right;
}

/// @description Keeps the player within the camera boundary.
/// @returns {Bool} Whether or not the player has fallen below the boundary relative to their rotation.
function player_in_camera_bounds()
{
	// Check if already within bounds (early out)
	if (mask_direction mod 180 != 0)
	{
		var x1 = x - y_radius;
		var y1 = y - x_radius;
		var x2 = x + y_radius;
		var y2 = y + x_radius;
	}
	else
	{
		var x1 = x - x_radius;
		var y1 = y - y_radius;
		var x2 = x + x_radius;
		var y2 = y + y_radius;
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
				x = camera.bound_left + x_radius;
				if (x_speed < 0) x_speed = 0;
			}
			if (x2 > camera.bound_right)
			{
				x = camera.bound_right - x_radius;
				if (x_speed > 0) x_speed = 0;
			}
			if (y2 + y_radius < camera.bound_top)
			{
				y = camera.bound_top - y_radius * 2;
			}
			if (y1 > camera.bound_bottom)
			{
				// Out of bounds
				y = camera.bound_bottom + y_radius;
				return false;
			}
			break;
		}
		
		// Right
		case 90:
		{
			if (y1 < camera.bound_top)
			{
				y = camera.bound_top + x_radius;
				if (x_speed > 0) x_speed = 0;
			}
			if (y2 > camera.bound_bottom)
			{
				y = camera.bound_bottom - x_radius;
				if (x_speed < 0) x_speed = 0;
			}
			if (x2 + y_radius < camera.bound_left)
			{
				x = camera.bound_left - y_radius * 2;
			}
			if (x1 > camera.bound_right)
			{
				x = camera.bound_right + y_radius;
				return false;
			}
			break;
		}
		
		// Up
		case 180:
		{
			if (x1 < camera.bound_left)
			{
				x = camera.bound_left + x_radius;
				if (x_speed > 0) x_speed = 0;
			}
			if (x2 > camera.bound_right)
			{
				x = camera.bound_right - x_radius;
				if (x_speed < 0) x_speed = 0;
			}
			if (y1 - y_radius > camera.bound_bottom)
			{
				y = camera.bound_bottom + y_radius * 2;
			}
			if (y2 < camera.bound_top)
			{
				y = camera.bound_top - y_radius;
				return false;
			}
			break;
		}
		
		// Left
		case 270:
		{
			if (y1 < camera.bound_top)
			{
				y = camera.bound_top + x_radius;
				if (x_speed < 0) x_speed = 0;
			}
			if (y2 > camera.bound_bottom)
			{
				y = camera.bound_bottom - x_radius;
				if (x_speed > 0) x_speed = 0;
			}
			if (x1 - y_radius > camera.bound_right)
			{
				x = camera.bound_right + y_radius * 2;
			}
			if (x2 < camera.bound_left)
			{
				x = camera.bound_left - y_radius;
				return false;
			}
			break;
		}
	}
	
	// Player is back within bounds
	return true;
}
/// @description Performs a movement step for the player on the ground.
/// @returns {Bool} Whether or not the player's state should be aborted.
function player_movement_ground()
{
	// Ride moving platforms
	with (ground_id)
	{
		// Horizontal motion
		var ox = x - xprevious;
		if (ox != 0) other.x += ox;
		
		// Vertical motion
		var oy = y - yprevious;
		if (oy != 0) other.y += oy;
	}
	
	// Initialize movement loop
	var total_steps = 1 + (abs(x_speed) div x_radius);
	var step = x_speed / total_steps;
	
	// Process movement loop
	repeat (total_steps)
	{
		// Apply movement step
		x += dcos(angle) * step;
		y -= dsin(angle) * step;
		
		// Die if out of bounds
		if (not player_in_camera_bounds())
		{
			player_is_dead(-1);
			return false;
		}
		
		// Find surrounding stage objects
		player_get_stage_objects();
		
		// Handle wall collision
		var hit_wall = player_collision_wall(0);
		if (hit_wall != noone)
		{
			// Eject from wall
			var wall_sign = player_wall_eject(hit_wall);
			
			// Trigger reaction
			if (player_react(hit_wall, wall_sign)) return false;
			
			// Stop if moving towards wall
			if (sign(x_speed) == wall_sign)
			{
				x_speed = 0;
				
				// Set pushing animation, if applicable
				var input_sign = input_right - input_left;
				if (animation_index != "push" and input_sign == wall_sign and image_xscale == wall_sign)
				{
					animation_index = "push";
					timeline_speed = 1;
				}
			}
		}
		
		// Handle floor collision
		var hit_floor = player_collision_floor(y_radius * 2);
		if (hit_floor != noone)
		{
			// Trigger reaction
			if (player_react(hit_floor, DIR_BOTTOM)) return false;
			
			// Get floor data
			player_set_ground(hit_floor);
		}
		else on_ground = false; // Fall off
		
		// Update mask direction
		if (on_ground) player_rotate_mask();
		
		// Handle non-solid object collision
		if (player_collision_soft()) return false;
	}
	
	// Success
	return true;
}

/// @description Performs a movement step for the player in the air.
/// @returns {Bool} Whether or not the player's state should be aborted.
function player_movement_air()
{
	// Initialize horizontal movement loop
	var total_steps = 1 + (abs(x_speed) div x_radius);
	var step = x_speed / total_steps;
	
	// Process horizontal movement loop
	repeat (total_steps)
	{
		// Apply movement step
		x += dcos(angle) * step;
		y -= dsin(angle) * step;
		
		// Die if out of bounds
		if (not player_in_camera_bounds())
		{
			player_is_dead(-1);
			return false;
		}
		
		// Find surrounding stage objects
		player_get_stage_objects();
		
		// Handle wall collision
		var hit_wall = player_collision_wall(0);
		if (hit_wall != noone)
		{
			// Eject from wall
			var wall_sign = player_wall_eject(hit_wall);
			
			// Trigger reaction
			if (player_react(hit_wall, wall_sign)) return false;
			
			// Stop if moving towards wall
			if (sign(x_speed) == wall_sign) x_speed = 0;
		}
		
		// Handle non-solid object collision
		if (player_collision_soft()) return false;
	}
	
	// Initialize vertical movement loop
	total_steps = 1 + (abs(y_speed) div y_radius);
	step = y_speed / total_steps;
	
	// Process vertical movement loop
	repeat (total_steps)
	{
		// Apply movement step
		x += dsin(angle) * step;
		y += dcos(angle) * step;
		
		// Die if out of bounds
		if (not player_in_camera_bounds())
		{
			player_is_dead(-1);
			return false;
		}
		
		// Find surrounding stage objects
		player_get_stage_objects();
		
		// Handle floor/ceiling collisions
		if (y_speed >= 0)
		{
			// Floor collision
			var hit_floor = player_collision_floor(y_radius);
			if (hit_floor != noone)
			{
				// Trigger reaction
				if (player_react(hit_floor, DIR_BOTTOM)) return false;
				
				// Get floor data
				player_set_ground(hit_floor);
				
				// Update mask direction
				player_rotate_mask();
			}
		}
		else
		{
			// Ceiling collision
			var hit_floor = player_collision_ceiling(y_radius);
			if (hit_floor != noone)
			{
				// Trigger reaction
				if (player_react(hit_floor, DIR_TOP)) return false;
				
				// Rotate mask to ceiling
				mask_direction = (mask_direction + 180) mod 360;
				
				// Get ceiling data
				player_set_ground(hit_floor);
				
				// Abort if rising too slow or ceiling is too shallow
				if (y_speed > ceiling_land_threshold or (relative_angle > 135 and relative_angle < 225))
				{
					// Slide against ceiling
					var sine = dsin(relative_angle);
					var cosine = dcos(relative_angle);
					var g_speed = (cosine * x_speed) - (sine * y_speed);
	                x_speed = cosine * g_speed;
					y_speed = -sine * g_speed;
					
					// Reset air state and exit loop
					player_set_ground(noone);
					break;
				}
			}
		}
		
		// Landing
		if (ground_id != noone)
		{
			// Calculate landing speed
			if (abs(x_speed) <= abs(y_speed) and relative_angle >= 22.5 and relative_angle <= 337.5)
			{
				// Scale speed to incline
			    x_speed = -y_speed * sign(dsin(relative_angle));
			    if (relative_angle < 45 or relative_angle > 315) x_speed *= 0.5;
			}
			
			// Stop falling
			y_speed = 0;
			
			// Set flags and exit loop
			jumping = false;
			camera.ground_mode = true;
			break;
		}
		
		// Handle wall collision (again)
		hit_wall = player_collision_wall(0);
		if (hit_wall != noone) player_wall_eject(hit_wall);
		
		// Handle non-solid object collision
		if (player_collision_soft()) return false;
	}
	
	// Success
	return true;
}
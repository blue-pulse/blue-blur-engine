/// @description Calculates the distance required to move the player's wall sensor out of collision with the given solid and does so accordingly.
/// @param {Id.Instance} obj Object or instance to check.
/// @returns {Real} Direction of the wall from the player, or 0 on failure.
function player_wall_eject(obj)
{
	var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	
	// Check if we're inside the wall
	if (collision_point(x, y, obj, true, false) != noone)
	{
		// Find and move to the closest side outside of collision
		for (var ox = x_wall_radius; ox < x_wall_radius * 2; ++ox)
		{
			// Right of the wall
			if (collision_ray_vertical(ox, 0, mask_direction, obj) == noone)
			{
				x += cosine * (x_wall_radius + ox);
				y -= sine * (x_wall_radius + ox);
				return -1;
			}
			else if (collision_ray_vertical(-ox, 0, mask_direction, obj) == noone)
			{
				// Left of the wall
				x -= cosine * (x_wall_radius + ox);
				y += sine * (x_wall_radius + ox);
				return 1;
			}
		}
	}
	else
	{
		// Find the closest side within collision
		for (var ox = x_wall_radius; ox > -1; --ox)
		{
			if (collision_ray(ox, 0, mask_direction, obj) == noone)
			{
				// Left of the wall
				if (collision_ray_vertical(ox + 1, 0, mask_direction, obj) != noone)
				{
					x -= cosine * (x_wall_radius - ox);
					y += sine * (x_wall_radius - ox);
					return 1;
				}
				else if (collision_ray_vertical(-(ox + 1), 0, mask_direction, obj) != noone)
				{
					// Right of the wall
					x += cosine * (x_wall_radius - ox);
					y -= sine * (x_wall_radius - ox);
					return -1;
				}
			}
		}
	}
	
	// Failure
	return 0;
}

/// @description Assigns the given solid as the terrain the player is standing on.
/// @param {Id.Instance} obj Object or instance to assign.
function player_set_ground(obj)
{
	// Reset ground and rotation values if no instance has been assigned
	if (obj == noone)
	{
		ground_id = noone;
		on_ground = false;
		angle = gravity_direction;
		relative_angle = 0;
		mask_direction = angle;
		camera.ground_mode = false;
		exit;
	}
	
	// Calculate new ground angle
	var new_angle = player_get_angle(obj, mask_direction);
	
	// Abort if terrain is too steep to map to
	if (on_ground and abs(angle_difference(new_angle, angle)) > 45)
	{
		on_ground = false;
		exit;
	}
	
	// Confirm ground
	ground_id = obj;
	on_ground = true;
	
	// Set new ground angle
	angle = new_angle;
	relative_angle = angle_wrap(angle - gravity_direction);
	
	// Align to ground
	var rotation = round(angle / 90) * 90;
	for (var oy = 0; oy < y_radius * 2; ++oy)
	{
		if (collision_box_vertical(x_radius, oy, rotation, ground_id) != noone)
		{
			var height = (y_radius - oy) + 1;
			x -= dsin(rotation) * height;
			y -= dcos(rotation) * height;
			break;
		}
	}
}

/// @description Rotates the player's collision mask along steep enough ground.
function player_rotate_mask()
{
	// Calculate rotational offset between angle and mask direction
	var diff = angle_difference(angle, mask_direction);
	
	// Abort if...
	if (abs(diff) <= 45 or abs(diff) >= 90) exit; // Offset is too steep or shallow
	if (collision_box(y_radius * 2, x_radius, (mask_direction mod 180 != 0), ground_id) == noone) exit; // Rotating would make the player fall
	
	// Calculate...
	var new_dir = angle_wrap(mask_direction + 90 * sign(diff)); // New mask direction
	var new_angle = player_get_angle(ground_id, new_dir); // Ground angle from new mask direction
	var new_diff = angle_difference(new_angle, mask_direction); // Rotational offset between new angle and mask direction
	
	// Abort if...
	if (sign(diff) != sign(new_diff)) exit; // Rotating the wrong way
	if (abs(new_diff) <= 45 or abs(new_diff) >= 90) exit; // New offset is too steep or shallow
	
	// Confirm rotation
	angle = new_angle;
	relative_angle = angle_wrap(angle - gravity_direction);
	mask_direction = new_dir;
}

/// @description Initializes the player's physics variables and then applies any active modifications.
function player_reset_physics()
{
	// Speed values
	speed_cap = 6;
	land_acceleration = 0.046875;
	land_deceleration = 0.5;
	land_friction = 0.046875;
	air_acceleration = 0.09375;
	roll_deceleration = 0.125;
	roll_friction = 0.0234375;
	
	// Aerial values
	gravity_cap = 16;
	gravity_force = 0.21875;
	recoil_gravity = 0.1875;
	jump_height = 6.5;
	jump_release = 4;
	
	// Superspeed modification
	if (superspeed_time > 0)
	{
		speed_cap *= 2;
		land_acceleration *= 2;
		land_friction *= 2;
		air_acceleration *= 2;
		roll_friction *= 2;
	}
}

/// @description Applies slope friction to horizontal speed if appropriate.
/// @param {Real} force Friction value to use.
function player_set_slope_friction(force)
{
	// Abort if...
	if (x_speed == 0 and control_lock_time <= 0) exit; // Not moving or sliding down
	if (relative_angle > 135 and relative_angle < 225) exit; // Attached to a ceiling
	if (relative_angle < 22.5 or relative_angle > 337.5) exit; // Moving on a shallow surface
	
	// Apply
	x_speed -= dsin(relative_angle) * force;
}
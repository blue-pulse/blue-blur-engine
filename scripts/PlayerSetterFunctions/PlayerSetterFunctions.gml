/// @description Rotates the player's collision mask along steep enough ground.
function player_rotate_mask()
{
	// Calculate rotational offset between angle and mask direction
	var diff = angle_difference(angle, mask_direction);
	
	// Abort if...
	if (abs(diff) <= 45 or abs(diff) >= 90) exit; // Offset is too steep or shallow
	if (collision_box(ver_radius * 2, hor_radius, (mask_direction mod 180 != 0), ground_id) == noone) exit; // Rotating would make the player fall
	
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
	if (hor_speed == 0 and control_lock_time <= 0) exit; // Not moving or sliding down
	if (relative_angle > 135 and relative_angle < 225) exit; // Attached to a ceiling
	if (relative_angle < 22.5 or relative_angle > 337.5) exit; // Moving on a shallow surface
	
	// Apply
	hor_speed -= dsin(relative_angle) * force;
}


/// @description Applies slope friction to horizontal speed if appropriate.
/// @param {Real} force Friction value to use.
function player_set_friction(force)
{
	// Abort if...
	if (hor_speed == 0 and control_lock_time <= 0) exit; // Not moving or sliding down
	if (relative_angle > 135 and relative_angle < 225) exit; // Attached to a ceiling
	if (relative_angle < 22.5 or relative_angle > 337.5) exit; // Moving on a shallow surface
	
	// Apply
	hor_speed -= dsin(relative_angle) * force;
}
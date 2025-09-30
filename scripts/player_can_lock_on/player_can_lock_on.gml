



/// @description Checks if the player can lock on to the given instance for a homing attack.
/// @param {Id.Instance} obj Object or instance to check.
/// @returns {Bool}
function player_can_lock_on(obj)
{
	// Abort if the instance is far away
	if (point_distance(x, y, obj.x, obj.y) > 128) return false;
	
	// Abort on an indirect line of sight
	with (obj)
	{
		if (collision_line(x, y, other.x, other.y, obj_solid, false, true) != noone)
		{
			return false;
		}
	}
	
	// Check against rotation
	switch (mask_direction)
	{
		case 0:
		{
			if (sign(obj.x - x) != image_xscale or y >= obj.y) return false;
			break;
		}
		case 90:
		{
			if (sign(y - obj.y) != image_xscale or x >= obj.x) return false;
			break;
		}
		case 180:
		{
			if (sign(x - obj.x) != image_xscale or y <= obj.y) return false;
			break;
		}
		case 270:
		{
			if (sign(obj.y - y) != image_xscale or x <= obj.x) return false;
			break;
		}
	}
	
	// Lock-on is possible
	return true;
}
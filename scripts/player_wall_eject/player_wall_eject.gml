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
		for (var ox = wall_radius; ox < wall_radius * 2; ++ox)
		{
			// Right of the wall
			if (collision_ray_vertical(ox, 0, mask_direction, obj) == noone)
			{
				x += cosine * (wall_radius + ox);
				y -= sine * (wall_radius + ox);
				return -1;
			}
			else if (collision_ray_vertical(-ox, 0, mask_direction, obj) == noone)
			{
				// Left of the wall
				x -= cosine * (wall_radius + ox);
				y += sine * (wall_radius + ox);
				return 1;
			}
		}
	}
	else
	{
		// Find the closest side within collision
		for (var ox = wall_radius; ox > -1; --ox)
		{
			if (collision_ray(ox, 0, mask_direction, obj) == noone)
			{
				// Left of the wall
				if (collision_ray_vertical(ox + 1, 0, mask_direction, obj) != noone)
				{
					x -= cosine * (wall_radius - ox);
					y += sine * (wall_radius - ox);
					return 1;
				}
				else if (collision_ray_vertical(-(ox + 1), 0, mask_direction, obj) != noone)
				{
					// Right of the wall
					x += cosine * (wall_radius - ox);
					y -= sine * (wall_radius - ox);
					return -1;
				}
			}
		}
	}
	
	// Failure
	return 0;
}
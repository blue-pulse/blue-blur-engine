/// @description Finds the first solid intersecting the wall sensor of the player's collision mask.
/// @param {Real} radius Distance to extend the wall sensor horizontally on both ends.
/// @returns {Id.Instance}
function player_collision_wall(radius)
{
	// Evaluate all solids
	for (var n = array_length(solid_objects) - 1; n > -1; --n)
	{
		// Get the current solid
		var inst = solid_objects[n];
		
		// Continue if passing through or not intersecting it
		if (inst.semisolid or collision_ray(x_wall_radius + radius, 0, mask_direction, inst) == noone) continue;
		
		// Confirm matching solid
		return inst;
	}
	
	// No solid found
	return noone;
}

/// @description Finds the first solid intersecting the lower half of the player's collision mask.
/// @param {Real} height Distance to extend the mask downward.
/// @returns {Id.Instance}
function player_collision_floor(height)
{
	// Extend mask up to height
	for (var oy = 0; oy < height; ++oy)
	{
		// Evaluate all solids
		for (var n = array_length(solid_objects) - 1; n > -1; --n)
		{
			// Get the current solid
			var inst = solid_objects[n];
			
			// Continue if...
			if (inst.semisolid and collision_ray(x_radius, 0, mask_direction, inst) != noone) continue; // Passing through it
			if (collision_box_vertical(x_radius, oy, mask_direction, inst) == noone) continue; // Not intersecting it
			
			// Confirm matching solid
			return inst;
		}
	}
	
	// No solid found
	return noone;
}

/// @description Finds the first solid intersecting the upper half of the player's collision mask.
/// @param {Real} height Distance to extend the mask upward.
/// @returns {Id.Instance}
function player_collision_ceiling(height)
{
	// Extend mask up to height
	for (var oy = 0; oy < height; ++oy)
	{
		// Evaluate all solids
		for (var n = array_length(solid_objects) - 1; n > -1; --n)
		{
			// Get the current solid
			var inst = solid_objects[n];
			
			// Continue if passing through or not intersecting it
			if (inst.semisolid or collision_box_vertical(x_radius, -oy, mask_direction, inst) == noone) continue;
			
			// Confirm matching solid
			return inst;
		}
	}
	
	// No solid found
	return noone;
}

/// @description Finds any non-solid objects intersecting the player's collision mask and triggers their reactions.
/// @returns {Bool} Whether or not the player's state should be aborted.
function player_collision_soft()
{
	// Evaluate all non-solids
	for (var n = array_length(soft_objects) - 1; n > -1; --n)
	{
		// Get the current non-solid
		var inst = soft_objects[n];
		
		// Continue if not intersecting it
		if (collision_box(x_radius, y_radius, (mask_direction mod 180 != 0), inst) == noone) continue;
		
		// Trigger reaction; abort state if applicable
		if (player_react(inst)) return true;
	}
	
	// Do not abort state
	return false;
}
/// @description Assigns the given solid as the terrain the player is standing on.
/// @param {Id.Instance} obj Object or instance to assign.
function player_set_ground(obj)
{
	// Reset ground and rotation values if no instance has been assigned
	if (obj == noone)
	{
		ground_id = noone;
		is_grounded = false;
		angle = gravity_direction;
		relative_angle = 0;
		mask_direction = angle;
		camera.ground_mode = false;
		exit;
	}
	
	// Calculate new ground angle
	var new_angle = player_get_angle(obj, mask_direction);
	
	// Abort if terrain is too steep to map to
	if (is_grounded and abs(angle_difference(new_angle, angle)) > 45)
	{
		is_grounded = false;
		exit;
	}
	
	// Confirm ground
	ground_id = obj;
	is_grounded = true;
	
	// Set new ground angle
	angle = new_angle;
	relative_angle = angle_wrap(angle - gravity_direction);
	
	// Align to ground
	var rotation = round(angle / 90) * 90;
	for (var oy = 0; oy < ver_radius * 2; ++oy)
	{
		if (collision_box_vertical(hor_radius, oy, rotation, ground_id) != noone)
		{
			var height = (ver_radius - oy) + 1;
			x -= dsin(rotation) * height;
			y -= dcos(rotation) * height;
			break;
		}
	}
}
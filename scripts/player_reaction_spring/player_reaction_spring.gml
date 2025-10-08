function player_reaction_spring(obj, side)
{
	// Get orientation relative to current rotation
	var rotation_offset = angle_wrap(obj.image_angle - mask_direction);
	
	// Ignore if not touching the correct side
	if ((side == DIR_RIGHT and rotation_offset != 90) or
		(side == DIR_LEFT and rotation_offset != 270) or
		(side == DIR_BOTTOM and rotation_offset != 0) or
		(side == DIR_TOP and rotation_offset != 180)) return false;
	
	// Get movement vectors
	var x_spring_speed = -dsin(rotation_offset) * obj.force;
	var y_spring_speed = -dcos(rotation_offset) * obj.force;
	
	// Bounce from spring
	if (x_spring_speed != 0)
	{
		hor_speed = x_spring_speed;
		image_xscale = sign(hor_speed);
		gnd_lock = 16;
	}
	if (y_spring_speed != 0)
	{
		// Set state
		player_is_falling(-1);
		
		// Movement
		ver_speed = y_spring_speed;
		
		// Set flags and animate if rising
		if (side == DIR_BOTTOM)
		{
			is_rolling = false;
			is_jumping = false;
			animation_index = "rise";
			image_angle = gravity_direction;
		}
	}
	
	// Animate spring
	obj.image_index = 0;
	obj.alarm[0] = 1;
	
	// Sound
	//audio_play_sfx(sfxSpring);
	
	// Abort state only if bouncing vertically
	return (y_spring_speed != 0);
}
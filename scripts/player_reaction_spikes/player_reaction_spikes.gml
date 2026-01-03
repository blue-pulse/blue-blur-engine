function player_reaction_spikes(object, side) {
	// Variables
	var rotation_offset = angle_wrap(object.image_angle - mask_direction);
	
	// Ignore if not touching the correct side
	if ((side == DIR_RIGHT and rotation_offset != 90)
		or (side == DIR_LEFT and rotation_offset != 270) 
		or (side == DIR_BOTTOM and rotation_offset != 0)
		or (side == DIR_TOP and rotation_offset != 180)
		) {
			return false;
	}
	
	// Abort state if player got hit
	return player_receive_damage(object);
}

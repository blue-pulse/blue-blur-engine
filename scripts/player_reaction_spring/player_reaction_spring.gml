function player_reaction_spring(object) {
	// Early exit
	if (!object.usable) {
		return false;
	}
	
	// Variables
	var spring_rotation = angle_wrap(object.image_angle - mask_direction);
	var spring_hspeed = -dsin(spring_rotation) * object.force;
	var spring_vspeed = -dcos(spring_rotation) * object.force;
	
	// Trigger
	object.image_speed = 1;
	object.alarm[0] = 10;
	object.usable = false;
	
	// FX
	screen_shake(7);
	audio_play_sfx(snd_spring, REPLACE);
	
	// Bounce horizontally
	if (spring_hspeed != 0) {
		y = floor(object.y);
		dir = sign(spring_hspeed);
		hor_speed = spring_hspeed;
		ground_lock = 16;
		return false;
	}
	
	// Bounce vertically
	if (spring_vspeed != 0) {
		// Variables
		x = floor(object.x);
		player_set_state(player_state_airbone);
		hor_speed = spring_hspeed;
		ver_speed = spring_vspeed;
		
		// Set flags and animate if rising
		if (spring_rotation == 0) {
			is_rolling = false;
			is_jumping = false;
			rotation = gravity_direction;
			animation_play(anim_rise);
		}
		
		// Set state
		return true;
	}
}

function player_reaction_spring(object) {
	// Early exit
	if (!object.usable) {
		return false;
	}
	
	// Variables
	var change_state = false;
	var spring_rotation = angle_wrap(object.image_angle - mask_direction);
	var spring_dcos = dcos(spring_rotation);
	var spring_dsin = dsin(spring_rotation);
	var spring_hspeed = spring_dcos * object.force;
	var spring_vspeed = -spring_dsin * object.force;
	
	// Trigger
	object.image_speed = 1;
	object.alarm[0] = 10;
	object.usable = false;
	
	// Fix position
	air_lock = 16;
	ground_lock = 16;
	x = object.x + object.draw_offset * spring_dcos;
	y = object.y - object.draw_offset * spring_dsin;
	
	// Bounce diagonally
	if (spring_rotation mod 90 != 0) {
		// State
		player_set_state(player_state_launch);
		change_state = true;
		
		// Variables
		is_rolling = false;
		is_jumping = false;
		hor_speed = spring_hspeed;
		ver_speed = spring_vspeed;
		dir = (spring_rotation > 90 and spring_rotation < 270) ? (-1) : (1);
	}
		
	// Bounce horizontally
	else if (spring_rotation mod 180 == 0) {
		hor_speed = spring_hspeed;
		ver_speed = 0;
		dir = sign(spring_hspeed);
		change_state = false;
	}
	
	// Bounce vertically
	else {
		// State
		player_set_state(player_state_airbone);
		change_state = true;
		
		// Variables
		hor_speed = 0;
		ver_speed = spring_vspeed;
		
		// Set flags if rising
		if (spring_rotation == 90) {
			animation_play(anim_rise);
			rotation = gravity_direction;
			is_rolling = false;
			is_jumping = false;
		}
	}
	
	// FX
	screen_shake(7);
	audio_play_sfx(snd_spring, REPLACE);
	
	// Change state
	return change_state;
}

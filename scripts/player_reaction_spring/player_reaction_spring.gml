function player_reaction_spring(object) {
	// Early exit
	if (!object.usable) {
		return false;
	}
	
	// Variables
	var spring_angle = object.image_angle;
	var spring_rotation = angle_wrap(spring_angle - mask_direction);
	var spring_dcos = dcos(spring_rotation);
	var spring_dsin = dsin(spring_rotation);
	var spring_hspeed = spring_dcos * object.force;
	var spring_vspeed = -spring_dsin * object.force;

	// Trigger
	object.image_speed = 1;
	object.alarm[0] = 10;
	object.usable = false;
	
	// FX
	screen_shake(7);
	audio_play_sfx(snd_spring, REPLACE);
	
	// Fix position
	air_lock = 16;
	ground_lock = 16;
	x = object.x;
	y = object.y;
	
	// Bounce diagonally
	if (spring_rotation mod 90 != 0) {
		// State
		player_set_state(player_state_launch);
		
		// Variables
		is_rolling = false;
		is_jumping = false;
		hor_speed = spring_hspeed;
		ver_speed = spring_vspeed;
		dir = (spring_rotation > 90 and spring_rotation < 270) ? (-1) : (1);
		return true;
	}
		
	// Bounce horizontally
	else if (spring_rotation mod 180 == 0) {
		hor_speed = spring_hspeed;
		ver_speed = 0;
		dir = sign(spring_hspeed);
		return false;
	}
	
	// Bounce vertically
	else {
		// State
		player_set_state(player_state_airbone);
		
		// Variables
		hor_speed = 0;
		ver_speed = spring_vspeed;
		
		// Set flags if rising
		if (spring_rotation == 90) {
			animation_play(anim_rise);
			y += lengthdir_y(object.draw_offset, spring_angle);
			rotation = gravity_direction;
			is_rolling = false;
			is_jumping = false;
		}
		return true;
	}
}

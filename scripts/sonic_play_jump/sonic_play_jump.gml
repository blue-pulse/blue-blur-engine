function sonic_play_jump() {
	// Early exit
	if (animation_is_playing(anim_roll_fast)) {
		exit;
	}
	
	// Variables
	var abs_speed = abs(hor_speed);
	var anim_speed = map(abs_speed, 0, 8, 2, 3);
	
	// Roll
	animation_play(anim_roll_fast, anim_speed);
	image_angle = gravity_direction;
	
	// Jumpball
	//TODO
}

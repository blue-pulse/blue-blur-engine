function sonic_animation_jump() {
	// Early exit
	if (animation_is_playing(anim_roll_jump)) {
		exit;
	}
	
	// Variables
	var abs_speed = abs(hor_speed);
	var anim_speed = map(abs_speed, 0, 8, 2, 3);
	rotation = gravity_direction;
	
	// Roll
	animation_play(anim_roll_jump, anim_speed);
	
	// Jumpball
	//TODO
}

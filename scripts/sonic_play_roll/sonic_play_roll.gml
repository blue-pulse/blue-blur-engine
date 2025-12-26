function sonic_play_roll() {
	// Variables
	var abs_speed = abs(hor_speed);
	
	// Fast roll
	if (abs_speed > 5) {
		var anim_speed = map(abs_speed, 5, 12, 1.25, 2.25);
		animation_play(anim_roll, anim_speed);
		image_angle = angle;
	} 
	
	// Slow roll
	else {
		var anim_speed = clamp(abs_speed, 1, 1.5);
		animation_play(anim_roll_slow, anim_speed);
		image_angle = gravity_direction;
	}
}

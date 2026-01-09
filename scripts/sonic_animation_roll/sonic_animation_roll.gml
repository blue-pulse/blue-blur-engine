function sonic_animation_roll() {
	// Early exit
	if (animation_is_playing(anim_dashpad)) {
		exit;
	}
	
	// Variables
	var abs_speed = abs(hor_speed);
	rotation = angle;
	
	// Fast roll
	if (abs_speed > 5) {
		var anim_speed = map(abs_speed, 5, 12, 1.25, 2.25);
		animation_play(anim_roll_fast, anim_speed);
	} 
	
	// Slow roll
	else {
		var anim_speed = clamp(abs_speed, 1, 1.5);
		animation_play(anim_roll_slow, anim_speed);
	}
}

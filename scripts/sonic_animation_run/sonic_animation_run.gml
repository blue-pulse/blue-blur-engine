function sonic_animation_run() {
	// Variables
	var abs_speed = abs(hor_speed);
	var anim_speed = 1;

	// Stroll
	if (abs_speed > 0 and abs_speed < 1.5) {
		anim_speed = clamp(abs_speed, 0.65, 1);
		animation_play(anim_stroll, anim_speed);
	}

	// Walk
	else if (abs_speed >= 1.5 and abs_speed < 3.0) {
		anim_speed = clamp(abs_speed, 0.65, 1);
		animation_play(anim_walk, anim_speed);
	}

	// Jog
	else if (abs_speed >= 3.0 and abs_speed < 4.5) {
		anim_speed = map(abs_speed, 3.0, 4.5, 1, 1.25);
		animation_play(anim_jog, anim_speed);
	}

	// Run
	else if (abs_speed >= 4.5 and abs_speed < 6.0) {
		anim_speed = map(abs_speed, 4.5, 6.0, 1, 1.35);
		animation_play(anim_run, anim_speed);
	}

	// Sprint
	else if (abs_speed >= 6.0) {
		var anim_speed = map(abs_speed, 6.0, 9.0, 1.5, 2.0);
		animation_play(anim_sprint, anim_speed);
	}
}

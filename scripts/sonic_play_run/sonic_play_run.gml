function sonic_play_run() {
	// Variables
	var current_speed = abs(hor_speed);
	var anim_speed = 1;

	// Stroll
	if (current_speed > 0 and current_speed < 1.5) {
		anim_speed = clamp(current_speed, 0.65, 1);
		animation_play(anim_stroll, anim_speed);
	}

	// Walk
	else if (current_speed >= 1.5 and current_speed < 3.0) {
		anim_speed = clamp(current_speed, 0.65, 1);
		animation_play(anim_walk, anim_speed);
	}

	// Jog
	else if (current_speed >= 3.0 and current_speed < 4.5) {
		anim_speed = map(current_speed, 3.0, 4.5, 1, 1.25);
		animation_play(anim_jog, anim_speed);
	}

	// Run
	else if (current_speed >= 4.5 and current_speed < 6.0) {
		anim_speed = map(current_speed, 4.5, 6.0, 1, 1.35);
		animation_play(anim_run, anim_speed);
	}

	// Sprint
	else if (current_speed >= 6.0 and current_speed < 9.0) {
		var anim_speed = map(current_speed, 6.0, 9.0, 1.5, 2.0);
		animation_play(anim_sprint, anim_speed);
	}

	// Peelout
	else if (current_speed >= 9.0) {
		anim_speed = map(current_speed, 9, 12, 1.5, 2.5);
		animation_play(anim_peelout, anim_speed);
	}
}

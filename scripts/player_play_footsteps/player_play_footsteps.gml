function player_play_footsteps(material) {
	// Static variables
	static counter = 0;
	static side = 0;

	// Early exit
	if (abs(gnd_speed) < 0.1) {
		counter = 0;
		side = 0;
		return;
	}

	// Sound logic
	counter += map(abs(gnd_speed), 0, max_abs_speed, 0.35, 2.25);
	if (counter >= 12) {
		counter = 0
		side = !side;
		audio_play_sfx(snd_footsteps[material][side]);
	}
}

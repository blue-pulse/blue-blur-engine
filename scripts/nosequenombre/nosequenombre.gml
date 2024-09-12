function nosequenombre() {
	// Variables
	var material = materials.generic;
	var dist_to_tile = 18;

	// See tile information based on current collision mode
	switch collision_mode[0] {
		// FLoor
		case 0:
			material = tile_find_material(pos_x, pos_y + dist_to_tile, plane);
			break;
		// Right wall
		case 1:
			material = tile_find_material(pos_x + dist_to_tile, pos_y, plane);
			break;
		// Cealing
		case 2:
			material = tile_find_material(pos_x, pos_y - dist_to_tile, plane);
			break;
		// Left wall
		case 3:
			material = tile_find_material(pos_x - dist_to_tile, pos_y, plane);
			break;
	}
	
	// Sonidos de pisadas
	audio_stop_sound(snd_tidal_tempest)
    static count = 10;
    if (abs(gnd_speed) > 0) {
        count += abs(gnd_speed)
        print(count)
        if (count >= 80) {
            count = 10
            var a = audio_play_sound(snd_footsteps[material], 1, false)
            var b = random_range(0.9, 1.1)
            audio_sound_pitch(a, b)
        }
    } else {
        count = 10
    }
	
	// Bloquear que se usen dos botones a la vez
	if (button_check("btn_left") and button_check("btn_right") or button_check("btn_up") and button_check("btn_down")) {
		input_lock_device(1);
	}
}

function player_drop_rings() {
	// Loop until no rings remain
	var spd = 4;
	var dir = 101.25;
	for (var ring = min(objGameData.player_rings, 32); ring > 0; --ring) {
		if (ring == 16) {
			spd = 2;
			dir = 101.25;
		}
		with (instance_create_layer(x, y, layer, objRingDropped)) {
			gravity_direction = other.gravity_direction;
			image_angle = gravity_direction;
			hor_speed = lengthdir_x(spd, dir);
			ver_speed = lengthdir_y(spd, dir);
			if (ring mod 2 != 0)
			{
				hor_speed *= -1;
				dir += 22.5;
			}
		}
	}
	
	// Reset ring count
	objGameData.player_rings = 0;
	
	// Sound
	audio_play_sfx(sfxRingLoss);
}

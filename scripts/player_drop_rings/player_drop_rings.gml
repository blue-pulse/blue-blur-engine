function player_drop_rings() {
	// Set default values we will use to spread rings
	var scatter_dir = -1;
	var angle = 101.25;
	var abs_speed = 4;
	
	// Handle rings on the floor
	for (var i = 0; i < min(rings, 32); i++) {
		// Spawn scattered ring
		var ring = instance_create_depth(x, y, depths.backstage, obj_ring_scattered);
		
		// Latest rings
		if (i == 15) {
			angle = 101.25;
			abs_speed = 2;
		}
		
		// Set initial values
		with (ring) {
			gravity_direction = other.gravity_direction;
			image_angle = other.gravity_direction;
			hor_speed = abs_speed * dcos(angle) * -scatter_dir;
			ver_speed = abs_speed * -dsin(angle);
		}
		
		// Change direction
		if (scatter_dir) then angle += 22.5;
		scatter_dir *= -1;
	}
	
	// Handle rings on the screen
	if (rings > 20) {
		// Parameters
		angle = 360;
		abs_speed = 12;
		
		// Show rings
		repeat (20) {
			vfx_create(x, y, obj_ring_screen, {
				hor_speed: abs_speed * dcos(angle) * -scatter_dir,
				ver_speed: abs_speed * -dsin(angle),
			}, true);
			if (scatter_dir) then angle -= 30;
			scatter_dir *= -1;
	    }
	}
	
	// Reset ring count
	rings = 0;
	
	// Sound
	audio_play_sfx(snd_ring_scatter, REPLACE);
}

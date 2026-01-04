function player_reaction_ring(object) {
	// Ignore if hit or starting to recover
	if (recovery_timer > 90 or array_contains([player_state_hurt, player_state_knockout], state)) {
		return false;
	}
	
	// Variables
	var amount = object.amount;
	var sound_fx = object.sound_fx;
	
	// Get sound
	if (is_array(sound_fx)) {
		sound_fx = (rings mod 2 == 0) ? (sound_fx[0]) : (sound_fx[1]);
	}
	
	// Collect ring
	player_add_rings(amount);
	
	// FX
	audio_play_sfx(sound_fx, REPLACE);
	part_particles_create(Particles, object.x, object.y, global.ring_sparkle, 1);
	
	// Destroy ring
	instance_destroy(object);

	// Do not abort state
	return false;
}

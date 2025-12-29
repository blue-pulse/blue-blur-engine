function player_reaction_ring(obj) {
	// Ignore if hit or starting to recover
	if (state == player_state_hurt or recovery_timer > 90) return false;
	
	// Collect ring
	player_add_rings(1);
	
	// Ring sparkle
	part_particles_create(global.particles, obj.x, obj.y, global.ring_sparkle, 1);
	
	// Destroy ring
	instance_destroy(obj);
	
	// Do not abort state
	return false;
}

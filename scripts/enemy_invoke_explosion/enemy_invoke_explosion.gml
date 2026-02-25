function enemy_invoke_explosion() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// FX
	audio_play_sfx(sfx_explosion);
	part_particles_create(Particles, x, y, vfx_explosion, 1);
	
	// Metal scraps
	repeat (random_range(4, 6)) {
		vfx_create(x, y, obj_metal_scraps, { explosion_timer: 15 }, true);	
    }
}

function enemy_invoke_explosion() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// FX
	audio_play_sfx(sfx_explosion);
	part_particles_create(Particles, x, y, vfx_explosion, 1);
}

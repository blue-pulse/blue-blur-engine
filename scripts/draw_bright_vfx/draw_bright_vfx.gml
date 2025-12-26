function draw_bright_vfx() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Draw self
	gpu_set_blendmode(bm_add);
	draw_self();
	gpu_set_blendmode(bm_normal);
}

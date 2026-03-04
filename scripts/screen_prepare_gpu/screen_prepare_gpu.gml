function screen_prepare_gpu() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	display_reset(2, true);
	surface_depth_disable(true);
	gpu_set_alphatestenable(true);
	gpu_set_alphatestref(0);
	gpu_set_texfilter(false);
}

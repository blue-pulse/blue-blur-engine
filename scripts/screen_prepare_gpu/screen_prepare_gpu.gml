function screen_prepare_gpu() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	gpu_set_alphatestenable(true);
	gpu_set_alphatestref(0);
	gpu_set_texfilter(false);
	gpu_set_ztestenable(false);
	gpu_set_zwriteenable(false);
	surface_depth_disable(true);
}

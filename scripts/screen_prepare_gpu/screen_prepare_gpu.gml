function screen_prepare_gpu() {
	surface_depth_disable(true);
	gpu_set_alphatestenable(true);
	gpu_set_alphatestref(0);
	gpu_set_texfilter(false);
}

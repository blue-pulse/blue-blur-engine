if (!Player.is_boosting) {
	// Sprite is offset one pixel to the left when mirrored. Let's fix that
	if (image_xscale == LEFT) {
		x--;
	}
	
	// Draw effect
	gpu_set_blendmode(bm_add);
	draw_self();
	gpu_set_blendmode(bm_normal);
}
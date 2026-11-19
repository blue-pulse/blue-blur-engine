function camera_restore_zoom() {
	// Logic
	with (obj_camera) {
		view_width = lerp(view_width, WIDTH, zoom_lerp);
		view_height = lerp(view_height, HEIGHT, zoom_lerp);
		zoom_amount = 1;
	}
}

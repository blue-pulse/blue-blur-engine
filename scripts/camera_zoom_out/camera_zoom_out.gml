function camera_zoom_out(rate=0.85, duration=25) {
	with (obj_camera) {
		zoom_amount = clamp(rate, 0, 1) + 1;
		zoom_timer = max(duration, 0);
	}
}

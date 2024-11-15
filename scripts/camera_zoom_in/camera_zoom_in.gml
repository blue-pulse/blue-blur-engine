function camera_zoom_in(rate=0.65, duration=25) {
	with (obj_camera) {
		zoom_amount = -0.5 * clamp(rate, 0, 1) + 1;
		zoom_timer = max(duration, 0);
	}
}

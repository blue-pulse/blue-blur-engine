function camera_zoom_out(amount=2, duration=25) {
	Camera.zoom_amount = clamp(amount, 1, 2);
	Camera.zoom_timer = max(duration, 0);
}

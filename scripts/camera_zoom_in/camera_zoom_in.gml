function camera_zoom_in(amount=0.5, duration=25) {
	Camera.zoom_amount = clamp(amount, 0.5, 1);
	Camera.zoom_timer = max(duration, 0);
}

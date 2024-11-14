function camera_zoom_in(amount=0.5, duration=25) {
	with (Camera) {
		zoom_amount = clamp(amount, 0.5, 1);
		zoom_timer = max(duration, 0);
	}
}

function camera_zoom_out(amount=2, duration=25) {
	with (Camera) {
		zoom_amount = clamp(amount, 1, 2);
		zoom_timer = max(duration, 0);
	}
}

function camera_zoom_in(_rate=0.65, _duration=25) {
	// Logic
	with (obj_camera) {
		zoom_amount = -0.5 * clamp(_rate, 0, 1) + 1;
		zoom_timer = max(_duration, 0);
	}
}

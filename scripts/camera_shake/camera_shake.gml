function camera_shake(_strength=2, _duration=25) {
	// Logic
	with (obj_camera) {
		shake_power = clamp(_strength, 1, 3);
		shake_timer = max(_duration, 0);
	}
}

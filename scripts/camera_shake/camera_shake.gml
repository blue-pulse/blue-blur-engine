function camera_shake(strength=2, duration=25) {
	with (Camera) {
		shake_power = clamp(strength, 1, 3);
		shake_timer = max(duration, 0);
	}
}

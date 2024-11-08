function camera_shake(_shake_timer, _shake_index) {
	Camera.shake_timer = clamp(_shake_timer, 1, 100);
	Camera.shake_index = clamp(_shake_index, 0.01, 1);
}

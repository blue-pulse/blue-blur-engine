function camera_zoom(_zoom_amount) {
	Camera.zoom_amount = clamp(_zoom_amount, -5, 5);
}

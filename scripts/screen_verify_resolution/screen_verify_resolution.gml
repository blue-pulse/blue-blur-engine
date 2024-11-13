function screen_verify_resolution() {
	var incorrect_width = (WIDTH / 2) mod 2 != 0;
	var incorrect_height = (HEIGHT / 2) mod 2 != 0;
	if (incorrect_width or incorrect_height) {
		print("[WARNING] Unsupported resolution!");
		print("[WARNING] Halved width or height isn't an even value. You may experience some issues because of that.");
	}
}
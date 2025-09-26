function screen_verify_size() {
	if ((WIDTH / 2) mod 2 or (HEIGHT / 2) mod 2 != 0) {
		print("[WARN] Halved width or height isn't an even value. You may experience some issues because of that.");
	}
}

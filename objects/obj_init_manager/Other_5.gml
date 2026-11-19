if (is_loading) {
	if (next_room == rm_title) {
		game_set_initialized(true);
		print("[INFO] Starting game...");
	}
} else {
	print("[INFO] Goodbye!");
}

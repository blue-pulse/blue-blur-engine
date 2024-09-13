// Debug shortcuts
if (global.debug) {
	// Toggle fullscreen
	if (keyboard_check_pressed(vk_f1)) {
		global.fullscreen = !global.fullscreen;
		screen_set_properties();
	}
	
	// Restart game
	if (keyboard_check_pressed(ord("R"))) {
		game_start();
	}
	
	// End game
	if (keyboard_check_pressed(vk_escape)) {
		game_end();
	}
	
	// Refill boost stamina
	if (keyboard_check_pressed(ord("W"))) {
		Player.stamina = 100;
	}
}

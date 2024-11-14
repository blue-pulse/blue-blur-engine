// Early exit
if (!instance_exists(Player)) {
	return;
}

// Timer
if (timer.display) {
	var value = "00:00.00";
	hud_draw_element(timer, value);
}

// Rings
if (rings.display) {
	var value = int_to_text(Player.rings, 3);
	hud_draw_element(rings, value);
}

// Stamina
if (stamina.display) {
	var value = Player.stamina * 1.4;
	hud_draw_stamina(value);
}

// Lives
if (life.display) {
	var value = int_to_text(global.lives, 2);
	hud_draw_element(life, value);
}

if (global.debug) {
	draw_text(10, 10, "FPS: " + string(fps));
	draw_text(10, 25, "GND: " + string(Player.gnd_speed));
	draw_text(10, 40, "HOR: " + string(Player.hor_speed));
	draw_text(10, 55, "VER: " + string(Player.ver_speed));
	draw_text(10, 70, "Stamina: " + string(Player.stamina));
}
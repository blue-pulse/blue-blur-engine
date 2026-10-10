// Options
for (var i = 0; i < options_count; ++i) {
	var option = options[i];
	option.x += option.hspeed;
	option.draw();
	draw_text_font_ext(option.x - 100, option.y, option.text, font_home_title, fa_center, fa_middle, 1, c_white, 1);
}

// Slot selector
if (!show_menu and option_active == 0) {
	draw_text_font_ext(WIDTH / 2, HEIGHT / 2, $"< Slot {slot_active} >", font_home_title, fa_center, fa_middle, 1, c_white, 1);
}

// Options
for (var _i = 0; _i < options_count; ++_i) {
	var _option = options[_i];
	_option.x += _option.hspeed;
	_option.draw();
	draw_text_font_ext(_option.x - 100, _option.y, _option.text, font_home_title, fa_center, fa_middle, 1, c_white, 1);
}

// Slot selector
if (!show_menu and option_active == 0) {
	draw_text_font_ext(WIDTH / 2, HEIGHT / 2, $"< Slot {slot_active} >", font_home_title, fa_center, fa_middle, 1, c_white, 1);
}

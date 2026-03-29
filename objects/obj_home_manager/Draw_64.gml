// Options
for (var i = 0; i < options_count; ++i) {
	var option = options[i];
	option.x += option.hspeed;
	option.draw();
	draw_text_font_ext(option.x - 100, option.y, option.text, font_home_title, fa_center, fa_middle, 1, c_white, 1);
}

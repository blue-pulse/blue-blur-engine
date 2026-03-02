function draw_text_font(pos_x, pos_y, text, font, hor_align=fa_left, ver_align=fa_top) {
	return draw_text_font_ext(pos_x, pos_y, text, font, hor_align, ver_align, 1, c_white, 1);
}

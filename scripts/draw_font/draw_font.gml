function draw_font(pos_x, pos_y, text, font=-1, hor_align=fa_left, ver_align=fa_top, alpha=1) {
	// Draw text using font
	draw_set_font(font);
	draw_set_halign(hor_align);
	draw_set_valign(ver_align);
	draw_text_color(pos_x, pos_y, text, c_white, c_white, c_white, c_white, alpha);
	
	// Restore font
	draw_set_font(-1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

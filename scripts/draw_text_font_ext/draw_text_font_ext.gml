function draw_text_font_ext(pos_x, pos_y, text, font, hor_align, ver_align, scale, color, alpha) {
	// Draw text using font
	draw_set_font(font);
	draw_set_halign(hor_align);
	draw_set_valign(ver_align);
	draw_text_transformed_colour(pos_x, pos_y, text, scale, scale, 0, color, color, color, color, alpha);
	
	// Restore font
	draw_set_font(-1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

// Time
if (show_time) {
	draw_sprite_ext(time_icon, 0, time_icon_x, time_icon_y, 1, 1, 0, time_tint, 1);
	draw_text_font_ext(time_text_x, time_text_y, time_text, font, fa_top, fa_top, 1, time_tint, 1);
}

// Rings
if (show_rings) {
	draw_sprite_ext(rings_icon, 0, rings_icon_x, rings_icon_y, 1, 1, 0, rings_tint, 1);
	draw_text_font_ext(rings_text_x, rings_text_y, rings_text, font, fa_top, fa_top, 1, rings_tint, 1);
}

// Lives
if (show_life) {
	draw_sprite_ext(life_icon, 0, life_icon_x, life_icon_y, 1, 1, 0, life_tint, 1);
	draw_text_font_ext(life_text_x, life_text_y, life_text, font, fa_top, fa_top, 1, life_tint, 1);
}

// Stamina
if (show_stamina) {
	draw_sprite_ext(stamina_icon, 0, stamina_icon_x, stamina_icon_y, 1, 1, 0, stamina_tint, 1);
	draw_line_width_colour(stamina_value_a_x, stamina_value_a_y, stamina_value_a_x + stamina_value, stamina_value_a_y, 1, stamina_color_0, stamina_color_1);
	draw_line_width_colour(stamina_value_b_x, stamina_value_b_y, stamina_value_b_x + stamina_value, stamina_value_b_y, 1, stamina_color_0, stamina_color_1);
}

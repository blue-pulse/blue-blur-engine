function hud_draw_stamina(value) {
	draw_sprite_ext(stamina.icon, 0, stamina.pos_icon[0], stamina.pos_icon[1], 1, 1, 0, c_white, alpha);
	draw_set_alpha(alpha);
	draw_line_width_colour(stamina.pos_info[0], stamina.pos_info[1], stamina.pos_info[0] + value, stamina.pos_info[1], 1, stamina.colors[0], stamina.colors[1]);
	draw_line_width_colour(stamina.pos_info[2], stamina.pos_info[3], stamina.pos_info[2] + value, stamina.pos_info[3], 1, stamina.colors[0], stamina.colors[1]);
	draw_set_alpha(1);
}

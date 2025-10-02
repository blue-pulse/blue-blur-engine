function hud_draw_element(element, value) {
	draw_sprite_ext(element.icon, 0, element.pos_icon[0], element.pos_icon[1], 1, 1, 0, c_white, alpha);
	draw_font(element.pos_info[0], element.pos_info[1], value, font, fa_top, fa_top, alpha);
}

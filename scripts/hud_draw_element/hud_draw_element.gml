function hud_draw_element(element, value) {
	draw_sprite(element.icon, 0, element.pos_icon[0], element.pos_icon[1]);
	draw_font(element.pos_info[0], element.pos_info[1], value, font, fa_top, fa_top);
}

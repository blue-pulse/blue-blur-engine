// Draw player collision masks
with (Player) {
	var x_int = floor(x);
	var y_int = floor(y);
	
	if (mask_direction mod 180 != 0) {
		draw_rectangle_color(x_int - ver_radius, y_int - hor_radius, x_int + ver_radius, y_int + hor_radius, c_lime, c_lime, c_lime, c_lime, true);
		draw_line_color(x_int, y_int - wall_radius, x_int, y_int + wall_radius, c_white, c_white);
	} else {
		draw_rectangle_color(x_int - hor_radius, y_int - ver_radius, x_int + hor_radius, y_int + ver_radius, c_lime, c_lime, c_lime, c_lime, true);
		draw_line_color(x_int - wall_radius, y_int, x_int + wall_radius, y_int, c_white, c_white);
	}
	draw_line_color(x_int, y_int, x_int + dsin(mask_direction) * ver_radius, y_int + dcos(mask_direction) * ver_radius, c_white, c_white);
	snip_draw_debug(x - 80, y + 30);
}

// Draw enemies collision masks
with (obj_enemy) {
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
	snip_draw_debug(x - 80, y + 30);
}

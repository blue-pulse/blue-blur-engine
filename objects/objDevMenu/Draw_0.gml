/// @description Draw collision masks
with (objPlayer)
{
	var x_int = x div 1;
	var y_int = y div 1;
	
	if (mask_direction mod 180 != 0)
	{
		draw_rectangle_color(x_int - y_radius, y_int - x_radius, x_int + y_radius, y_int + x_radius, c_lime, c_lime, c_lime, c_lime, true);
		draw_line_color(x_int, y_int - x_wall_radius, x_int, y_int + x_wall_radius, c_white, c_white);
	}
	else
	{
		draw_rectangle_color(x_int - x_radius, y_int - y_radius, x_int + x_radius, y_int + y_radius, c_lime, c_lime, c_lime, c_lime, true);
		draw_line_color(x_int - x_wall_radius, y_int, x_int + x_wall_radius, y_int, c_white, c_white);
	}
	draw_line_color(x_int, y_int, x_int + dsin(mask_direction) * y_radius, y_int + dcos(mask_direction) * y_radius, c_white, c_white);
}
with (objBadnik)
{
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
}
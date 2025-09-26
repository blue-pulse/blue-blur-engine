/// @description Scanlines filter
draw_set_alpha(0.125);
for (var oy = 0.5; oy < SCREEN_HEIGHT; oy += 2)
{
	draw_line_width_color(-1, oy, SCREEN_WIDTH, oy, 1, c_black, c_black);
}
draw_set_alpha(1);
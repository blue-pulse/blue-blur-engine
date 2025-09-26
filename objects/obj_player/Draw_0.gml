/// @description Draw character

// Trail (AUTHOR NOTE: this code was copied from Sonic MAX and Sonic Astral Engine.)
draw_primitive_begin(pr_trianglestrip);
var width = 13;
for (var n = 1; n < table_size; ++n)
{
	// Get current coordinates
	var ox = x_table[n];
	var oy = y_table[n];
	
	// Calculate angle and vectors from previous coordinates
	var dir = point_direction(ox, oy, x_table[n - 1], y_table[n - 1]) + 90;
	var dx = lengthdir_x(width, dir);
	var dy = lengthdir_y(width, dir);
	
	// Calculate alpha, and render
	var alpha = trail_alpha[n] * (n / table_size) * 0.9;
	draw_vertex_color(ox - dx, oy - dy, c_blue, alpha);
	draw_vertex_color(ox + dx, oy + dy, c_blue, alpha);
}
draw_primitive_end();

// Character sprite
var x_int = x div 1;
var y_int = y div 1;
draw_sprite_ext(sprite_index, image_index, x_int, y_int, image_xscale, 1, round(image_angle / 45) * 45, c_white, image_alpha);

// Dash smoke
if (state == player_is_spindashing or state == player_is_peelouting)
{
	draw_sprite_ext(sprDashSmoke, objScreen.image_index div 2, x_int, y_int, image_xscale, 1, mask_direction, c_white, 1);
}
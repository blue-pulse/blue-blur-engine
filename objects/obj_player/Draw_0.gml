// Trail
draw_primitive_begin(pr_trianglestrip);
var width = 13;
for (var n = 1; n < table_size; ++n) {
	// Get current coordinates
	var ox = pos_grid[0, n];
	var oy = pos_grid[1, n];
	
	// Calculate angle and vectors from previous coordinates
	var dir = point_direction(ox, oy, pos_grid[0, n - 1], pos_grid[1, n - 1]) + 90;
	var dx = lengthdir_x(width, dir);
	var dy = lengthdir_y(width, dir);
	
	// Calculate alpha, and render
	var alpha = trail_alpha[n] * (n / table_size) * 0.9;
	draw_vertex_color(ox - dx, oy - dy, c_blue, alpha);
	draw_vertex_color(ox + dx, oy + dy, c_blue, alpha);
}
draw_primitive_end();

// Character sprite
draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, 1, round(image_angle / 45) * 45, c_white, image_alpha);

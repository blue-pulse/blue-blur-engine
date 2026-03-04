function player_draw_trail() {
	// Variables
	var offset = (array_contains(trail_offset_states, state)) ? (dcos(rotation) * 5) : (0);

	// Prepare triangles
	draw_primitive_begin(pr_trianglestrip);
	
	// Draw a triangle for every previous position
	for (var i = 1; i < table_size; ++i) {
		// Get coordinates
		var j = i - 1;
		var tex_size = j / table_size;
		var pos_x_1 = pos_grid[0, j];
		var pos_y_1 = pos_grid[1, j] + offset;
		var pos_x_2 = pos_grid[0, i];
		var pos_y_2 = pos_grid[1, i] + offset;
	
		// Calculate angle and vectors from previous coordinates
		var angle = point_direction(pos_x_2, pos_y_2, pos_x_1, pos_y_1) + 90;
		var dir_x = lengthdir_x(trail_width, angle);
		var dir_y = lengthdir_y(trail_width, angle);
	
		// Calculate alpha, and render
		var alpha = trail_alpha * tex_size;
		draw_vertex_texture_color(floor(pos_x_2 + dir_x), floor(pos_y_2 + dir_y), tex_size, 0, color_blend, alpha);
		draw_vertex_texture_color(floor(pos_x_2 - dir_x), floor(pos_y_2 - dir_y), tex_size, 1, color_blend, alpha);
	}
	
	// Stop drawing triangles
	draw_primitive_end();
}

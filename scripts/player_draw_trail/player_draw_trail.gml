function player_draw_trail(color, width=10) {
	// Variables
	var offset = (state == player_state_roll) ? (dcos(rotation) * 5) : (0);
	
	// Prepare triangles
	draw_primitive_begin(pr_trianglestrip);
	
	// Draw a triangle for every previous position
	for (var i = 1; i < table_size; ++i) {
		// Get coordinates
		var pos_x_1 = pos_grid[0, i];
		var pos_y_1 = pos_grid[1, i] + offset;
		var pos_x_2 = pos_grid[0, i - 1];
		var pos_y_2 = pos_grid[1, i - 1] + offset;
	
		// Calculate angle and vectors from previous coordinates
		var angle = point_direction(pos_x_1, pos_y_1, pos_x_2, pos_y_2) + 90;
		var dir_x = lengthdir_x(width, angle);
		var dir_y = lengthdir_y(width, angle);
	
		// Calculate alpha, and render
		var alpha = trail_alpha[i] * (i / table_size) * 0.9;
		draw_vertex_color(floor(pos_x_1 - dir_x), floor(pos_y_1 - dir_y), color, alpha);
		draw_vertex_color(floor(pos_x_1 + dir_x), floor(pos_y_1 + dir_y), color, alpha);
	}
	
	// Stop drawing triangles
	draw_primitive_end();
}

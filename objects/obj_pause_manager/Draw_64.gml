if (is_pausing) {
	// Background
	draw_surface_ext(pause_surface, 0, 0, scale_x, scale_y, 0, c_white, 0.10);
	
	// Title
	draw_sprite(spr_pause_title, 0, pos_x, pos_y);
	
	// Options
	for (var _i = 0; _i < options_count; ++_i) {
	    options[_i].draw();
	}
}

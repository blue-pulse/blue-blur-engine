if (in_process) {
	// Background
	draw_surface_ext(pause_surface, 0, 0, scale_x, scale_y, 0, c_white, 0.10);
	
	// Title
	draw_sprite(spr_pause_title, 0, pos_x, pos_y);
	
	// Options
	for (var i = 0; i < options_length; ++i) {
	    options[i].draw();
	}
}

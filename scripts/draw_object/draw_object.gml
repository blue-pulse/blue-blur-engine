function draw_object() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Variables
	var pos_x = floor(x);
	var pos_y = floor(y);
	var color = draw_get_color();
	
	// Draw self
	draw_sprite_ext(sprite_index, image_index, pos_x, pos_y, image_xscale, image_yscale, image_angle, color, image_alpha);
}

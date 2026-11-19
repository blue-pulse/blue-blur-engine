function draw_object() {
	// Variables
	var _pos_x = floor(x);
	var _pos_y = floor(y);
	var _color = draw_get_color();
	
	// Draw self
	draw_sprite_ext(sprite_index, image_index, _pos_x, _pos_y, image_xscale, image_yscale, image_angle, _color, image_alpha);
}

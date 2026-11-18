// Draw bridge
var _offset = ratio * sprite_width;
for (var _i = 0; _i < sprite_width; _i += node_width) {
	// Get relative tension
	var _height = tension;
	if (_i < _offset) {
		_height *= dsin((_i / _offset) * 90);
	} else if (_i > _offset) {
		_height *= dsin(((sprite_width - _i) / (sprite_width - _offset)) * 90);
	}
	
	// Draw nodes
	draw_sprite(sprite_index, 0, bbox_left + _i, ystart + _height);
}

// Draw posts
draw_sprite_ext(post_sprite, 0, post_left_pos, post_height, 1, 1, 0, c_white, 1);
draw_sprite_ext(post_sprite, 0, post_right_pos, post_height, -1, 1, 0, c_white, 1);

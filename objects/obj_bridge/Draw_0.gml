// Draw bridge
var offset = ratio * sprite_width;
for (var i = 0; i < sprite_width; i += node_width) {
	// Get relative tension
	var height = tension;
	if (i < offset) {
		height *= dsin((i / offset) * 90);
	} else if (i > offset) {
		height *= dsin(((sprite_width - i) / (sprite_width - offset)) * 90);
	}
	
	// Draw nodes
	draw_sprite(sprite_index, 0, bbox_left + i, ystart + height);
}

// Draw posts
draw_sprite_ext(post_sprite, 0, post_left_pos, post_height, 1, 1, 0, c_white, 1);
draw_sprite_ext(post_sprite, 0, post_right_pos, post_height, -1, 1, 0, c_white, 1);

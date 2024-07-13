// Setup
x = floor(pos_x);
y = floor(pos_y);
image_angle = rotation;
image_alpha = opacity;

// Update the facing direction only if not rolling
if (state != states.rolling) {
	image_xscale = facing;
}

// Draw player
draw_self();
draw_line(x, y, x+radius_x, y);
draw_line(x, y, x-radius_x, y);
draw_line(x, y, x, y+radius_y);
draw_line(x, y, x, y-radius_y);
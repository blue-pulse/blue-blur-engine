// Setup
x = floor(pos_x);
y = floor(pos_y);
image_angle = rotation;
image_alpha = opacity;
image_speed = delta(image_speed);

// Update the facing direction only if not rolling
if (state != states.rolling) {
	image_xscale = facing;
}

// Draw player
draw_self();
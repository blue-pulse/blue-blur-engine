// Prepare parameters
x = floor(pos_x);
y = floor(pos_y);
image_angle = rotation;
image_alpha = opacity;

// Update the direction only if not rolling
if (state != states.rolling) {
	image_xscale = dir;
}

// Draw player
draw_self();

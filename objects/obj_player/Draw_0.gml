// Prepare parameters
x = floor(pos_x);
y = floor(pos_y);
image_angle = rotation;
image_alpha = opacity;

// Update the direction only if not rolling
if (state != states.roll) {
	image_xscale = dir;
}

// Blink sprite
if (invincibility_frames and !is_being_hurt) {
	var should_maintain = invincibility_frames mod 4;
	if (!should_maintain) {
		image_alpha = !image_alpha;
	}
} else {
	image_alpha = 1;
}

// Draw player
draw_self();

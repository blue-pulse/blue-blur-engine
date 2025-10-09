// Abort if the player is no longer jumping
if (!owner.is_rolling) {
	instance_destroy();
	exit;
}

// Update position
x = floor(target.x);
y = floor(target.y);

// Fade in
if (image_alpha < 1) {
	image_alpha = lerp(image_alpha, 1, 0.15);
}

// Scale down circle
if (circle_scale > scale_limit) {
	circle_scale = lerp(circle_scale, scale_limit, 0.5);
}

// Scale down arrow
if (arrow_scale > scale_limit) {
	arrow_scale = lerp(arrow_scale, scale_limit, 0.5);
}

// Rotate
circle_angle += 5;
arrow_angle -= 5;

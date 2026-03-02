// Move ring
x += hor_speed;
y += ver_speed;

// Increase size
image_alpha -= 0.025;
image_xscale += 0.25;
image_yscale += 0.25;

// Destroy ring
if (image_alpha <= 0) {
	instance_destroy();
}

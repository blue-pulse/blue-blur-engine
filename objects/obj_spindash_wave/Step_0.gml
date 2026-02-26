// Destroy if not visible
if (image_alpha <= 0) {
	instance_destroy();
}

// Parameters
image_alpha -= 0.125;
image_angle += 20;
image_xscale += 0.12;
image_yscale += 0.12;

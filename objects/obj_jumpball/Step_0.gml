// Abort if not jumping
if (owner.animation != hook) {
	instance_destroy();
	exit;
}

// Update position
x = floor(owner.x);
y = floor(owner.y);
image_xscale = owner.dir;

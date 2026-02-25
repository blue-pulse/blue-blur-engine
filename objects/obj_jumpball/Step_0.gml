// Stick to the player position
if (owner.animation == hook) {
	x = floor(owner.x);
	y = floor(owner.y);
	image_xscale = owner.dir;
} 

// Destroy effect
else {
	instance_destroy();
}

// Handle effect
if (Player.is_boosting) {
	// Stick to the player position
	x = Player.x;
	y = Player.y;

	// Animation angle
	image_angle = point_direction(xprevious, yprevious, x, y);
	
	// Increase alpha
	if (image_alpha < 0.65) {
		image_alpha += 0.125;
	}
}

// Destroy if the animation alpha is equal to 0
else {
	image_alpha -= 0.125;
    if (image_alpha <= 0) {
		instance_destroy();
	}
}

if (Player.is_boosting) {
	// Increase alpha
	if (image_alpha < 0.65) {
		image_alpha += 0.125;
	}
} else {
	// Destroy if the animation alpha is equal to 0
	image_alpha -= 0.125;
    if (image_alpha <= 0) {
		instance_destroy();
	}
}

// Stick to the player position
x = Player.x;
y = Player.y;

// Animation angle
image_angle = point_direction(xprevious, yprevious, x, y);

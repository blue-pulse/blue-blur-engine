// Handle effect
if (Player.is_boosting) {
	// Stick to the player position
	x = Player.x;
	y = Player.y;

	// Animation angle
	var prev_angle = image_angle;
	image_angle = point_direction(xprevious, yprevious, x, y);
	
	// Fix visual bug when jumping
	if (Player.is_jumping and image_angle == 270) {
		image_angle = lerp(prev_angle, image_angle, 0.015);
	}

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

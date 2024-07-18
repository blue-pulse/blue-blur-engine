// Destroy if the animation alpha is equal to 0
if (image_alpha <= 0) {
	instance_destroy();
}

// Increase alpha if the player started to boost
if (image_alpha < 0.8 && Player.is_boosting) {
	image_alpha += 0.05;
}

// Fade if the player stopped boosting
if (!Player.is_boosting || abs(Player.hor_speed) < 2.2) {
	image_alpha -= 0.05;
}

// Stick to the player position
x = Player.x;
y = Player.y;

// Animation angle
image_angle = point_direction(xprevious, yprevious, x, y);

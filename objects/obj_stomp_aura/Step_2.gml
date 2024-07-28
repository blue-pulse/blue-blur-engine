if (Player.is_stomping) {
	// Stick to the player position
	x = floor(Player.pos_x);
	y = floor(Player.pos_y - Player.radius_y);

	// Increase alpha
	if (image_alpha < 1) {
		image_alpha += 0.25;
	}
} else {
	// Destroy if the animation alpha is equal to 0
	image_alpha -= 0.25;
    if (image_alpha <= 0) {
		instance_destroy();
	}
}
if (Player.is_stomping) {
	// Increase alpha
	Player.state = states.stomping
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

// Stick to the player position
x = Player.x;
y = Player.y;

// Destroy effect
if (Player.state != states.jumping) {
	instance_destroy();
}

// Stick to the player position
else {
	x = Player.pos_x;
	y = Player.pos_y;
}
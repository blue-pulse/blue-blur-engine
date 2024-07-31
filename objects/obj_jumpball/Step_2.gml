// Destroy effect
if (Player.state != states.jumping) {
	instance_destroy();
}

// Stick to the player position
else {
	x = floor(Player.pos_x);
	y = floor(Player.pos_y);
	image_xscale = Player.dir;
}
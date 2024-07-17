x = floor(Player.pos_x);
y = floor(Player.pos_y + Player.radius_y);	

// Destroy if not spindashing anymore
if (Player.spindash_revolutions == -1) {
	instance_destroy();
}
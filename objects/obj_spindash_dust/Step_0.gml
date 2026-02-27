// Abort if the player does not spindash
if (owner.state != player_state_spindash) {
	instance_destroy();
	exit;
}

// Update position
x = floor(owner.x);
y = floor(owner.y);

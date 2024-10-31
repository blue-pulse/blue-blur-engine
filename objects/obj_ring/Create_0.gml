// Set basic parameters
depth = orders.backstage;

// Set variables
instance_set_hitbox(6, 6);
increase = 1;

// Set methods
get_sfx = function() {
	return (Player.rings mod 2 == 0) ? (snd_ring_left) : (snd_ring_right);
}

// Variables
depth = queue.backstage;
value = 1;
instance_set_hitbox(6, 6);

// Methods
get_sfx = function() {
	return (Player.rings mod 2 == 0) ? (snd_ring_left) : (snd_ring_right);
}

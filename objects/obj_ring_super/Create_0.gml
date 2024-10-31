// Inherit the parent event
event_inherited();

// Set variables
instance_set_hitbox(8, 8);
increase = 10;

// Set methods
get_sfx = function() {
	return snd_ring_super;
}

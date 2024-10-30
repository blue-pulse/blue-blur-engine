// Set global variables
depth = orders.backstage;

// Set basic parameters
increase = 1;

// Set methods
ring_play_sfx = function() {
	audio_play_sfx(Player.rings mod 2 == 0 ? snd_ring_left : snd_ring_right);
}

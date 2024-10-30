// Collect ring
if (!Player.is_being_hurt and Player.invincibility_frames < 90) {
	// object_check_player(ColHitbox)
	if (object_check_player()) {
		// Increase amount
		Player.rings += increase;
		
		// FX
		ring_play_sfx();
		//instance_create(x, y, RingSparkle);	
		
		// Destroy object
		instance_destroy();
	}
}

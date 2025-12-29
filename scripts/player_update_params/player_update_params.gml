function player_update_params() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Reduce ground lock
	if (is_grounded and ground_lock) {
		--ground_lock;
	}
	
	// Recovery frames handling
	if (recovery_timer) {
		alpha = (recovery_timer & 4 > 0) * 1;
		if (--recovery_timer == 0) {
			alpha = 1;
		}
	}
	
	// Invincibility effect
	if (invincibility_timer and --invincibility_timer <= 0) {
		instance_destroy(invincibility_fx);
		invincibility_fx = noone;
		//audio_dequeue_bgm(bgmInvincibility, true);
	}
	
	// Superspeed
	if (superspeed_timer and --superspeed_timer <= 0) {
		player_update_physics();
	}
}
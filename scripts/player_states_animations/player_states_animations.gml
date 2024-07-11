function player_states_animations() {
	if ((horizontal_speed == 0) and is_grounded and (state == states.idle)) {
	    snip_play_next(my_snip, true);
	}
	
	if (state == states.crouching) {
	    snip_play(my_sni2, true);
	}
}
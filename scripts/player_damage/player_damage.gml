function player_damage() {
	screen_shake(15);
	with (Player) {
		player_set_state(states.hurt);
	}
}
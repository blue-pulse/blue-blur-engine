function player_set_states() {
	enum states {
		idle = 0,
		moving = 1,
		crouching = 2,
		pushing = 3,
		skidding = 4,
		searching = 5,
		rolling = 6,
		spindash = 7,
		
		AnimBalance = 99,
		AnimBalanceTurn = 98,
		AnimBalancePanic = 97,
		AnimBalanceFlip = 96,
	}
}
// Player enums
enum states {
    idle,
    moving,
    falling,
    jumping,
    landing,
    searching,
    crouching,
    rolling,
    spindash,
    skidding,
    pushing,
    balancing,
    balancing_flip,
    balancing_panic,
    balancing_turn,
}

// Drawing depths and audio priorities
enum orders {
	// Audio
	bgm = 0,
	sfx = 1,
	
	// Depths
	entities = 0,
	effects = 0,
	player = -1,
	controller = -4096,
}

// Drawing depths and audio priorities
enum orders {
	// Audio
	bgm = 100,
	sfx = 1,
	voices = 2,
	
	// Depths
	entities = 0,
	effects = 0,
	player = -1,
	gui = -100,
	controller = -4096,
}

// Floor materials
enum materials {
	generic = 0,
	grass = 1,
	dirt = 2,
	wood = 3,
	metal = 4,
	stone = 5,
	glass = 6,
	water = 7,
}

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
	stomping,
	sliding,
}

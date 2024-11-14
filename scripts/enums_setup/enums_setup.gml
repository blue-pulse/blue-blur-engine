// Drawing and audio priorities
enum orders {
	// Audio
	bgm = 100,
	sfx = 1,
	voices = 2,
	
	// Depths
	effects = 0,
	enemies = 0,
	backstage = 1,
	player = -1,
    frontstage = -2,
	gui = -100,
	controller = -4096,
}

// Floor materials
enum materials {
	generic,
	dirt,
	glass,
	grass,
	metal,
	stone,
	water,
	wood,
}

// States enums
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
	turning,
}

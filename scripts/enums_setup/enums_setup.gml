// Drawing and audio priorities
enum queue {
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
    move,
    fall,
    jump,
    land,
    search,
    crouch,
    roll,
    spindash,
    skid,
    push,
    balance,
    balance_flip,
    balance_panic,
    balance_turn,
	stomp,
	slide,
	hurt,
	knockout,
	turn,
}

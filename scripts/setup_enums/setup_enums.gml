// Shapes
enum shapes {
	wall = 0,
	slope = 1,
	pipe = 2,
	ellipse = 3,
	custom = 4,
}

// Drawing priorities
enum depths {
	backstage = 1,
	enemies = 0,
	player = -1,
    frontstage = -2,
	effects = -2,
	gui = -100,
	manager = -4096,
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

// Characters
enum chars {
	adventure = 0,
	amy = 1,
	classic = 2,
	knux = 3,
	shadow = 4,
	sonic = 5,
	tails = 6,
	test = 7,
}

// Items
enum items {
	none = 0,
	rings_5 = 1,
	rings_10 = 2,
	rings_rand = 3,
	life = 4,
	stamina = 5,
}

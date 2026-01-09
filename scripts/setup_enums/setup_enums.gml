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

// Characters
enum chars {
	advance,
	adventure,
	amy,
	classic,
	knux,
	shadow,
	sonic,
	tails,
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

// Shapes
enum shapes {
	wall = 0,
	slope = 1,
	pipe = 2,
	ellipse = 3,
	custom = 4,
}

// Logic priorities
enum queue {
	bgm = 100,
	sfx = 1,
	voices = 2,
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

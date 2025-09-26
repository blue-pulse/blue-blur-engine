// Shapes
enum shapes {
	rectangle = 0,
	right_triangle = 1,
	quarter_pipe = 2,
	quarter_ellipse = 3,
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

// States
enum states {
	init = 0,
	run = 1,
	stop = 2,
}

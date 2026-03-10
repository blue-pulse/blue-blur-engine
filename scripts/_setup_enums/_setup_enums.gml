// Async operations
enum tasks {
	read = 0,
	write = 0,
	remove = 0,
	pending = 0,
	completed = 0,
	failed = 0,
}

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
	maximum = 6144,
	backstage = 1,
	enemies = 0,
	player = -1,
    frontstage = -2,
	effects = -2,
	gui = -100,
	manager = -4096,
	minimum = -6144,
}

// Culling settings
enum cull {
	freq = 10,
	margin = 192,
	offset = 96,
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

// Items
enum items {
	none = 0,
	rings_5 = 1,
	rings_10 = 2,
	rings_rand = 3,
	life = 4,
	stamina = 5,
}

function tile_get_material(index) {
	switch (index) {
		// Grass
		case 147:
		case 402:
		case 657:
			return materials.grass;
		// Dirt
		case 148:
		case 403:
		case 658:
			return materials.dirt;
		// Wood
		case 149:
		case 404:
		case 659:
			return materials.wood;
		// Metal
		case 150:
		case 405:
		case 660:
			return materials.metal;
		// Stone
		case 151:
		case 406:
		case 661:
			return materials.stone;
		// Glass
		case 152:
		case 407:
		case 662:
			return materials.glass;
		// Generic
		default:
			return materials.generic;
	}
}

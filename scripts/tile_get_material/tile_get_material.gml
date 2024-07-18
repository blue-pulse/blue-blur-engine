function tile_get_material(index) {
	switch(index) {
		// Air
		case 0:
			return noone;
		// Grass
		case 146:
		case 401:
		case 656:
			return materials.grass;
			break;
		// Dirt
		case 147:
		case 402:
		case 657:
			return materials.dirt;
			break;
		// Wood
		case 148:
		case 403:
		case 658:
			return materials.wood;
			break;
		// Metal
		case 149:
		case 404:
		case 659:
			return materials.metal;
			break;
		// Stone
		case 150:
		case 405:
		case 660:
			return materials.stone;
			break;
		// Glass
		case 151:
		case 406:
		case 661:
			return materials.glass;
			break;
		default:
			return materials.generic;
			break;		
	}
}
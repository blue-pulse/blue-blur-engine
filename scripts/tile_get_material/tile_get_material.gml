function tile_get_material(index) {
	switch (index) {
		// Grass
		case 147:
		case 402:
		case 657:
			print("Grass");
			return materials.grass;
		// Dirt
		case 148:
		case 403:
		case 658:
			print("Dirt");
			return materials.dirt;
		// Wood
		case 149:
		case 404:
		case 659:
			print("Wood");
			return materials.wood;
		// Metal
		case 150:
		case 405:
		case 660:
			print("Metal");
			return materials.metal;
		// Stone
		case 151:
		case 406:
		case 661:
			print("Stone");
			return materials.stone;
		// Glass
		case 152:
		case 407:
		case 662:
			print("Glass");
			return materials.glass;
		// Generic
		default:
			print("Generic");
			return materials.generic;
	}
}

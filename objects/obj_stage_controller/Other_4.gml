// Stage setup
switch (room) {
	case rm_practice_zone:
		stage_setup_practice();
		break;
	default:
		tile_set_data(noone, 0, "", "");
		break;
}

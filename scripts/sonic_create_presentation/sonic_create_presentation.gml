function sonic_create_presentation(clips) {
	// Return value
	return player_create_presentation(clips, { jump_ball: { object: obj_jumpball, sprite: data_dash.sprite } });
}

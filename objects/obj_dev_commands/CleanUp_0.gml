// Release player
if (instance_exists(game_get_player()) and game_get_player().state == player_state_noclip) {
	with (game_get_player()) {
		player_set_state(player_state_airbone);
	}
}

// Give the camera back unless the game unset it on purpose
if (instance_exists(obj_camera) and camera_get_target() != noone and instance_exists(camera_target_before)) {
	camera_set_target(camera_target_before);
}

// Give the HUD back
if (instance_exists(obj_hud) and hud_get_visibility() != hud_visible_before) {
	hud_set_visibility(hud_visible_before);
}

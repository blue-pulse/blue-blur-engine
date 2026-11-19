function dev_define_commands() {
	// Commands
	return [
		{ key: vk_f1, has_shift: false, label: "Noclip", is_player_required: true, run: dev_command_toggle_noclip },
		{ key: vk_f2, has_shift: false, label: "Gain rings", is_player_required: true, run: dev_command_add_rings },
		{ key: vk_f3, has_shift: false, label: "Rotate gravity clockwise", is_player_required: true, run: dev_command_rotate_gravity_cw },
		{ key: vk_f4, has_shift: false, label: "Rotate gravity anticlockwise", is_player_required: true, run: dev_command_rotate_gravity_ccw },
		{ key: vk_f5, has_shift: false, label: "Restart room", is_player_required: false, run: dev_command_restart_room },
		{ key: vk_f6, has_shift: false, label: "Focus camera", is_player_required: true, run: dev_command_toggle_camera },
		{ key: vk_f7, has_shift: false, label: "Toggle HUD", is_player_required: false, run: dev_command_toggle_hud },
		{ key: vk_f8, has_shift: false, label: "Restart game", is_player_required: false, run: framework_restart },
		{ key: vk_f9, has_shift: true, label: "Quit game", is_player_required: false, run: framework_quit },
		{ key: vk_f11, has_shift: false, label: "Toggle fullscreen", is_player_required: false, run: dev_command_toggle_fullscreen },
	];
}

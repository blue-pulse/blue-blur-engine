function dev_define_commands() {
	// Commands
	return [
		{ key: vk_f1, has_shift: false, label: "Noclip", needs_player: true, run: dev_command_toggle_noclip },
		{ key: vk_f2, has_shift: false, label: "Gain rings", needs_player: true, run: dev_command_add_rings },
		{ key: vk_f3, has_shift: false, label: "Rotate gravity clockwise", needs_player: true, run: dev_command_rotate_gravity_cw },
		{ key: vk_f4, has_shift: false, label: "Rotate gravity anticlockwise", needs_player: true, run: dev_command_rotate_gravity_ccw },
		{ key: vk_f5, has_shift: false, label: "Restart room", needs_player: false, run: dev_command_restart_room },
		{ key: vk_f6, has_shift: false, label: "Focus camera", needs_player: true, run: dev_command_toggle_camera },
		{ key: vk_f7, has_shift: false, label: "Toggle HUD", needs_player: false, run: dev_command_toggle_hud },
		{ key: vk_f8, has_shift: false, label: "Restart game", needs_player: false, run: framework_restart },
		{ key: vk_f9, has_shift: true, label: "Quit game", needs_player: false, run: framework_quit },
		{ key: vk_f11, has_shift: false, label: "Toggle fullscreen", needs_player: false, run: dev_command_toggle_fullscreen },
	];
}

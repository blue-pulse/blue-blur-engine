function dev_define_commands() {
	// Commands
	return [
		{ key: vk_f1, shift: false, label: "Noclip", needs_player: true, run: dev_command_toggle_noclip },
		{ key: vk_f2, shift: false, label: "Gain rings", needs_player: true, run: dev_command_add_rings },
		{ key: vk_f3, shift: false, label: "Rotate gravity clockwise", needs_player: true, run: dev_command_rotate_gravity_cw },
		{ key: vk_f4, shift: false, label: "Rotate gravity anticlockwise", needs_player: true, run: dev_command_rotate_gravity_ccw },
		{ key: vk_f5, shift: false, label: "Restart room", needs_player: false, run: dev_command_restart_room },
		{ key: vk_f6, shift: false, label: "Focus camera", needs_player: true, run: dev_command_toggle_camera },
		{ key: vk_f7, shift: false, label: "Toggle HUD", needs_player: false, run: dev_command_toggle_hud },
		{ key: vk_f8, shift: false, label: "Restart game", needs_player: false, run: framework_restart },
		{ key: vk_f9, shift: true, label: "Quit game", needs_player: false, run: framework_quit },
		{ key: vk_f11, shift: false, label: "Toggle fullscreen", needs_player: false, run: dev_command_toggle_fullscreen },
	];
}

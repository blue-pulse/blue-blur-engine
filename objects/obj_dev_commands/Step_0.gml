// Early exit
if (is_keyboard_used_debug_overlay()) {
	exit;
}

// Run the shortcuts
for (var _i = 0; _i < array_length(commands); _i++) {
	var _command = commands[_i];
	if (keyboard_check_pressed(_command.key) and keyboard_check(vk_shift) == _command.shift) {
		dev_run_command(_command);
	}
}

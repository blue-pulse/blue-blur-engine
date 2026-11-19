function input_script_define() {
	// Script state
	global.input_script = { source: undefined, step: 0 };

	// Take the buttons from the script after Input reads the device
	InputPlugInDefine("BlueBlur.ScriptedInput", "Blue Blur Engine", "1.0.0", "10.5", function() {
		InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.COLLECT_PLAYER, -1, function(_player) {
			// Variables
			var _script = global.input_script;

			// Early exit
			if (_script.source == undefined or _player != PLAYER_SLOT) {
				exit;
			}

			// Set every button unless the player is blocked
			if (!InputPlayerGetBlocked(PLAYER_SLOT)) {
				for (var _button = 0; _button <= vb_y; _button++) {
					var _value = _script.source(_script.step, _button) ? 1 : 0;
					InputPlugInVerbSet(_button, _value, _value, PLAYER_SLOT);
				}
			}
			_script.step++;
		});
	});
}

// Define the plug-in at start only for a replay
if (REPLAY_SCENARIO != "") {
	input_script_define();
}

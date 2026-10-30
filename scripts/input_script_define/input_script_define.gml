function input_script_define() {
	// Script state
	global.input_script = { source: undefined, step: 0 };

	// Take the buttons from the script after Input collected the device
	InputPlugInDefine("BlueBlur.ScriptedInput", "Blue Blur Engine", "1.0.0", "10.5", function() {
		InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.COLLECT_PLAYER, -1, function(_player) {
			// Variables
			var script = global.input_script;

			// Early exit
			if (script.source == undefined or _player != PLAYER_SLOT) {
				exit;
			}

			// Set every button unless the player is blocked
			if (!InputPlayerGetBlocked(PLAYER_SLOT)) {
				for (var button = 0; button <= vb_y; button++) {
					var value = script.source(script.step, button) ? 1 : 0;
					InputPlugInVerbSet(button, value, value, PLAYER_SLOT);
				}
			}
			script.step++;
		});
	});
}

// Define the plug-in when the game starts, and only for a replay
if (REPLAY_SCENARIO != "") {
	input_script_define();
}

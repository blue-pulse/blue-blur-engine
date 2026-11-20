// Count the step
ticks++;

// Start the next stage when the scene is ready
if (!is_playing and stage_index < array_length(stages)) {
	if (stage_index == 0 or (instance_exists(game_get_player()) and !scene_is_changing())) {
		random_set_seed(1);
		is_recording = (stage_index == record_stage);
		if (!is_recording) {
			input_script_start(stages[stage_index].source);
		}

		// Tell the player that the keyboard is theirs
		else {
			mixer_play_effect(snd_menu_confirm);
		}
		is_playing = true;
		print($"[REPLAY] stage {stage_index} starts at tick {ticks}");
	}
}

// Finish the stage when its buttons run out
else if (is_playing and !is_recording and input_script_get_step() >= stages[stage_index].steps) {
	input_script_stop();
	is_playing = false;
	stage_index++;
}

// Record the buttons the player holds
if (is_recording) {
	var _mask = 0;
	for (var _button = 0; _button <= vb_y; _button++) {
		if (input_held(_button)) {
			_mask |= (1 << _button);
		}
	}
	print($"[RECORD] {_mask}");
}

// Print the state when it changes
var _state = replay_format_state(paths);
if (_state != last_state) {
	last_state = _state;
	array_push(state_lines, $"{ticks} {_state}");
	print($"[REPLAY] state {ticks} {_state}");
}

// End the game after the last stage
if (!is_playing and stage_index >= array_length(stages)) {
	game_end();
}

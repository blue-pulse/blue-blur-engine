// Variables
var _replay = global.replay;

// Wait for the player
if (!_replay.is_started) {
	if (instance_exists(game_get_player()) and !scene_is_changing()) {
		random_set_seed(1);
		print("[REPLAY] start ticks " + string(global.framecount) + " room " + room_get_name(room) + " x " + string(game_get_player().x) + " y " + string(game_get_player().y));
		if (!_replay.is_recording) {
			input_script_start(_replay.plan.source);
		}
		_replay.is_started = true;
	}
	exit;
}

// Write down the buttons the player holds while recording
if (_replay.is_recording) {
	var _mask = 0;
	for (var _button = 0; _button <= vb_y; _button++) {
		if (input_held(_button)) {
			_mask |= (1 << _button);
		}
	}
	print("[RECORD] " + string(_mask));
	exit;
}

// Record the step
var _step = input_script_get_step();
with (game_get_player()) {
	array_push(_replay.logic_lines, replay_format_step(_step));
	var _balls = instance_number(obj_jumpball);
	array_push(_replay.picture_lines, string(_step) + " " + sprite_get_name(sprite_index) + "#" + string(image_index) + ((_balls > 0) ? (" ball" + string(_balls)) : ""));
	print("[REPLAY] " + _replay.logic_lines[array_length(_replay.logic_lines) - 1] + " " + _replay.picture_lines[array_length(_replay.picture_lines) - 1]);
}

// Report and stop at the end of the scenario
if (_step >= _replay.plan.steps) {
	input_script_stop();
	print("[REPLAY] logic " + md5_string_utf8(string_join_ext("|", _replay.logic_lines)));
	print("[REPLAY] picture " + md5_string_utf8(string_join_ext("|", _replay.picture_lines)));
	game_end();
}

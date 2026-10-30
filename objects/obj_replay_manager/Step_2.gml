// Variables
var replay = global.replay;

// Wait for the player
if (!replay.started) {
	if (instance_exists(Protagonist) and !scene_is_changing()) {
		random_set_seed(1);
		print("[REPLAY] start ticks " + string(ticks) + " room " + room_get_name(room) + " x " + string(Protagonist.x) + " y " + string(Protagonist.y));
		if (!replay.recording) {
			input_script_start(replay.plan.source);
		}
		replay.started = true;
	}
	exit;
}

// Write down the buttons the player holds while recording
if (replay.recording) {
	var mask = 0;
	for (var button = 0; button <= vb_y; button++) {
		if (input_held(button)) {
			mask |= (1 << button);
		}
	}
	print("[RECORD] " + string(mask));
	exit;
}

// Record the step
var step = input_script_get_step();
with (Protagonist) {
	array_push(replay.logic_lines, replay_format_step(step));
	var balls = instance_number(obj_jumpball);
	array_push(replay.picture_lines, string(step) + " " + sprite_get_name(sprite_index) + "#" + string(image_index) + ((balls > 0) ? (" ball" + string(balls)) : ""));
	print("[REPLAY] " + replay.logic_lines[array_length(replay.logic_lines) - 1] + " " + replay.picture_lines[array_length(replay.picture_lines) - 1]);
}

// Report and stop at the end of the scenario
if (step >= replay.plan.steps) {
	input_script_stop();
	print("[REPLAY] logic " + md5_string_utf8(string_join_ext("|", replay.logic_lines)));
	print("[REPLAY] picture " + md5_string_utf8(string_join_ext("|", replay.picture_lines)));
	game_end();
}

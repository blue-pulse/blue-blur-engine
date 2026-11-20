// Parameters
scenario = replay_define_scenarios()[$ REPLAY_SCENARIO];
stages = array_map(scenario.stages, function(_segments) {
	return replay_create_source(_segments);
});
paths = replay_list_files();
record_stage = scenario[$ "record_stage"] ?? -1;

// Variables
stage_index = 0;
is_playing = false;
is_recording = false;
ticks = 0;
state_lines = [];
last_state = "";
storage_was_active = false;

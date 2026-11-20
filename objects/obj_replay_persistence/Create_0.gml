// Parameters
scenario = replay_define_scenarios()[$ REPLAY_SCENARIO];
stages = array_map(scenario.stages, function(_segments) {
	return replay_create_source(_segments);
});
paths = replay_list_files();

// Variables
stage_index = 0;
is_playing = false;
ticks = 0;
state_lines = [];
last_state = "";

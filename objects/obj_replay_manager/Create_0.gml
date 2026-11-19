// Parameters
scenario = replay_define_scenarios()[$ REPLAY_SCENARIO];

// Shared by every room of the run, so a restarted room goes on with the same script
if (!variable_global_exists("replay")) {
	global.replay = {
		plan: replay_create_source(scenario.segments),
		is_recording: scenario[$ "recording"] ?? false,
		is_started: false,
		logic_lines: [],
		picture_lines: [],
	};
}

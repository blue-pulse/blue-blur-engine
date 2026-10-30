function player_create_presentation(clips, effects) {
	// Shared parts
	var jump_pose = {
		run: selector_start,
		clip: clips.roll_jump,
		fact: "speed",
		pace: { map: [0, 8, 2, 3] },
		effect: effects.jump_ball,
	};
	var curl_up = { run: selector_on_count, fact: "curl_ups", then: jump_pose };
	var fall_slow = { run: selector_on_count, fact: "monitor_bounces", then: { run: selector_direct, clip: clips.fall_slow } };

	// Return value
	return {
		rows: [
			{
				state: player_state_idle,
				entry: [
					{
						run: selector_by_fact,
						fact: "ledge",
						cases: [
							{ value: 0, clip: clips.idle },
							{ value: 1, clip: clips.balance_front },
							{ value: -1, clip: clips.balance_back },
						],
					},
				],
			},
			{ state: player_state_crouch, entry: [{ run: selector_direct, clip: clips.crouch }] },
			{ state: player_state_lookup, entry: [{ run: selector_direct, clip: clips.lookup }] },
			{ state: player_state_dashpanel, entry: [{ run: selector_direct, clip: clips.dashpanel }] },
			{ state: player_state_hurt, entry: [{ run: selector_direct, clip: clips.hurt }] },
			{ state: player_state_death, entry: [{ run: selector_direct, clip: clips.hurt }] },
			{ state: player_state_knockout, entry: [{ run: selector_direct, clip: clips.knockout }] },
			{
				state: player_state_airbone,
				entry: [
					{ run: selector_by_fact, fact: "rolling", cases: [{ value: false, clip: clips.fall_fast }] },
					{ run: selector_while_fact, fact: "rising", clip: clips.rise },
				],
				follow: [
					{
						run: selector_on_change,
						fact: "rising",
						cases: [
							{ to: true, then: { run: selector_direct, clip: clips.rise } },
							{ to: false, then: { run: selector_direct, clip: clips.fall } },
						],
					},
					curl_up,
					fall_slow,
				],
			},
			{ state: player_state_homing, entry: [jump_pose] },
			{ state: player_state_jump, entry: [jump_pose], follow: [curl_up] },
			{ state: player_state_launch, entry: [{ run: selector_direct, clip: clips.launch }], follow: [fall_slow] },
			{
				state: player_state_turn,
				entry: [
					{
						run: selector_by_fact,
						fact: "braking_turn",
						cases: [
							{ value: true, clip: clips.skid_turn },
							{ value: false, clip: clips.turn },
						],
					},
				],
			},
			{
				state: player_state_skid,
				entry: [
					{
						run: selector_by_band,
						fact: "speed",
						cases: [
							{ from: 6, clip: clips.skid_fast },
							{ from: 0, clip: clips.skid_slow },
						],
					},
				],
			},
			{
				state: player_state_roll,
				follow: [
					{
						run: selector_ladder,
						fact: "speed",
						bands: [
							{ above: 5, clip: clips.roll_fast, pace: { map: [5, 12, 1.25, 2.25] } },
							{ from: 0, clip: clips.roll_slow, pace: { limit: [1, 1.5] } },
						],
					},
				],
			},
			{
				state: player_state_run,
				follow: [
					{
						run: selector_ladder,
						fact: "speed",
						unless: "pushing",
						bands: [
							{ from: 6, clip: clips.sprint, pace: { map: [6, 9, 1.5, 2] } },
							{ from: 4.5, clip: clips.run, pace: { map: [4.5, 6, 1, 1.35] } },
							{ from: 3, clip: clips.jog, pace: { map: [3, 4.5, 1, 1.25] } },
							{ from: 1.5, clip: clips.walk, pace: { limit: [0.65, 1] } },
							{ above: 0, clip: clips.stroll, pace: { limit: [0.65, 1] } },
						],
					},
					{ run: selector_while_fact, fact: "pushing", clip: clips.push },
				],
			},
			{
				state: player_state_spindash,
				entry: [{ run: selector_direct, clip: clips.spindash }],
				follow: [
					{ run: selector_on_count, fact: "spindash_revs", then: { run: selector_direct, clip: clips.spindash_charge } },
				],
			},
		],
	};
}

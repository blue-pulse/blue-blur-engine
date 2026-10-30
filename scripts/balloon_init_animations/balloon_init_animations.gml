function balloon_init_animations() {
	// Variables
	static clips = {
		idle: animation_create(spr_balloon_idle),
		attack: animation_create(spr_balloon_attack),
	};
	static presentation = {
		rows: [
			{ state: balloon_states.idle, entry: [{ run: selector_direct, clip: clips.idle }] },
			{ state: balloon_states.attack, entry: [{ run: selector_direct, clip: clips.attack }] },
		],
	};

	// Initialize variables
	animation_init();
	presentation_init(presentation, { state: state });

	// Start the first animation
	presentation_update();
}

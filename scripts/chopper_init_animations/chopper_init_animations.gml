function chopper_init_animations() {
	// Variables
	static clips = {
		attack: animation_create(spr_chopper_attack),
	};
	static presentation = {
		rows: [
			{ state: chopper_states.fly, entry: [{ run: selector_direct, clip: clips.attack }] },
		],
	};

	// Initialize variables
	animation_init();
	presentation_init(presentation, { state: state });

	// Start the first animation
	presentation_update();
}

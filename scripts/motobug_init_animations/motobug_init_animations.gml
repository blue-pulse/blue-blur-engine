function motobug_init_animations() {
	// Variables
	static clips = {
		attack: animation_create(spr_motobug_attack),
		turn: animation_create(spr_motobug_turn),
	};
	static presentation = {
		rows: [
			{ state: motobug_states.move, entry: [{ run: selector_direct, clip: clips.attack }] },
			{ state: motobug_states.turn, entry: [{ run: selector_direct, clip: clips.turn }] },
		],
	};

	// Initialize variables
	animation_init();
	presentation_init(presentation, { state: state });

	// Start the first animation
	presentation_update();
}

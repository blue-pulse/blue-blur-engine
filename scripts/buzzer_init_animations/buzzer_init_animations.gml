function buzzer_init_animations() {
	// Variables
	static clips = {
		fly: animation_create(spr_buzzer_fly),
		turn: animation_create(spr_buzzer_turn),
		attack: animation_create(spr_buzzer_attack),
	};
	static presentation = {
		rows: [
			{ state: buzzer_states.fly, entry: [{ run: selector_direct, clip: clips.fly }] },
			{ state: buzzer_states.turn, entry: [{ run: selector_direct, clip: clips.turn }] },
			{ state: buzzer_states.attack, entry: [{ run: selector_direct, clip: clips.attack }] },
		],
	};

	// Initialize variables
	animation_init();
	presentation_init(presentation, { state: state });

	// Start the first animation
	presentation_update();
}

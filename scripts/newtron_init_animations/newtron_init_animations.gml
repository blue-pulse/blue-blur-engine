function newtron_init_animations() {
	// Variables
	static clips = {
		idle: animation_create(spr_newtron_idle),
		fade_in: animation_create(spr_newtron_idle),
		attack: animation_create(spr_newtron_attack),
		fade_out: animation_create(spr_newtron_idle, { reversed: true }),
	};
	static presentation = {
		rows: [
			{ state: newtron_states.wait, entry: [{ run: selector_direct, clip: clips.idle }] },
			{ state: newtron_states.fade_in, entry: [{ run: selector_direct, clip: clips.fade_in }] },
			{ state: newtron_states.attack, entry: [{ run: selector_direct, clip: clips.attack }] },
			{ state: newtron_states.fade_out, entry: [{ run: selector_direct, clip: clips.fade_out }] },
		],
	};

	// Initialize variables
	animation_init();
	presentation_init(presentation, { state: state });

	// Start the first animation
	presentation_update();
}

function sonic_init_animations() {
	// Variables
	static clips = player_resolve_clips(sonic_create_animations());
	static presentation = sonic_create_presentation(clips);

	// Initialize variables
	animation_init();

	// Share the presentation between instances
	presentation_set = presentation;

	// Register the transitions once
	sonic_init_transitions(clips);
}

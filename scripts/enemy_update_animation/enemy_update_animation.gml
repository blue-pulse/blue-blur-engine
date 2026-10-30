function enemy_update_animation() {
	// Advance the animation and show its frame
	animation_update();

	// Choose the animation
	presentation_facts.state = state;
	presentation_update();
}

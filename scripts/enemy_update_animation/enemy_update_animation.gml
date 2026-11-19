function enemy_update_animation() {
	// Advance the animation first so a new clip shows a step late (0012)
	animation_update();

	// Choose the animation
	presentation_facts.state = state;
	presentation_update();
}

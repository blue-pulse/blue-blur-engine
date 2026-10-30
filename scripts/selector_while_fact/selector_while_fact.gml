function selector_while_fact(facts, params) {
	// Play the animation on every step the fact holds
	if (facts[$ params.fact]) {
		animation_play(params.clip);
	}
}

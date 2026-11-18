function selector_while_fact(_facts, _params) {
	// Play the animation on every step the fact holds
	if (_facts[$ _params.fact]) {
		animation_play(_params.clip);
	}
}

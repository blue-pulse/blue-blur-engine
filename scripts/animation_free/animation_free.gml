function animation_free() {
	// Remove the transitions of this instance
	for (var i = 0; i < array_length(__animation_transitions); i++) {
		var pair = __animation_transitions[i];
		resnip_transition_remove(pair[0], pair[1]);
	}
	__animation_transitions = [];
}

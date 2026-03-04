function player_update_animation() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Enable animations
	animation_setup_run();

	// Update trail alpha
	var trail_factor = safe_div(trail_span, trail_reference);
	trail_alpha = lerp(trail_alpha, trail_factor, trail_decay_rate);
}

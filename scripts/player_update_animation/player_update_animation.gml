function player_update_animation() {
	// Enable animations
	animation_setup_run();

	// Update trail alpha
	var alpha_val = (is_rolling and (x != xprevious or y != yprevious));
	array_delete(trail_alpha, 0, 1);
	array_push(trail_alpha, alpha_val);
}

function player_update_anims() {
	// Enable animations
	snip_step_event();

	// Update trail alpha
	var alpha_val = (animation_index == "spin" and (x != xprevious or y != yprevious));
	array_delete(trail_alpha, 0, 1);
	array_push(trail_alpha, alpha_val);
}

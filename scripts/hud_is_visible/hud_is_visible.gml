function hud_is_visible() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	with (obj_hud) {
		return (
			(!show_time or time_tint == c_white) and
			(!show_rings or rings_tint == c_white) and
			(!show_life or life_tint == c_white) and
			(!show_stamina or stamina_tint == c_white)
		);
	}
	return false;
}

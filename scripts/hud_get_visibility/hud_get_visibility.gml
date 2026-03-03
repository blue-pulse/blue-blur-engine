function hud_get_visibility() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return obj_hud.viewable;
}

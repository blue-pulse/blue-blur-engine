function hud_set_visibility(_visibility) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Logic
	obj_hud.viewable = _visibility;
}

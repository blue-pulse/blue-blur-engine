function gui_create(object, var_struct={}) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	if (!instance_exists(object)) {
		return instance_create_depth(0, 0, depths.gui, object, var_struct);
	}
	return noone;
}

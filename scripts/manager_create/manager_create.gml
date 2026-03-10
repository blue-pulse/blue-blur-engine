function manager_create(object) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	if (!instance_exists(object)) {
		return instance_create_depth(0, 0, depths.manager, object);
	}
	return noone;
}

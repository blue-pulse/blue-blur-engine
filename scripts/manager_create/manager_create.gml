function manager_create(_object) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	if (!instance_exists(_object)) {
		return instance_create_depth(0, 0, depths.manager, _object);
	}
	return noone;
}

function manager_create(object) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return instance_create_depth(0, 0, depths.manager, object);
}

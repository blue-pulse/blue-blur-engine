function vfx_create(pos_x, pos_y, object, var_struct={}, overlap=false) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	if (overlap or !instance_exists(object)) {
        return instance_create_depth(pos_x, pos_y, depths.effects, object, var_struct);
    }
	return noone;
}

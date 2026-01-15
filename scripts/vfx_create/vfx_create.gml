function vfx_create(pos_x, pos_y, object, var_struct={}, overlap=false, caller=noone) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	if (overlap or !instance_exists(object)) {
		// Set owner
		if (caller == noone) {
			caller = id;
		}
		var_struct.owner = caller;
		
		// Return object
        return instance_create_depth(pos_x, pos_y, depths.effects, object, var_struct);
    }
	return noone;
}

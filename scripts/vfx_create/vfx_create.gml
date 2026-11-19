function vfx_create(_pos_x, _pos_y, _object, _var_struct={}, _allow_overlap=false) {
	// Return value
	if (_allow_overlap or !instance_exists(_object)) {
		// Set owner
		if (!variable_struct_exists(_var_struct, "owner")) {
			_var_struct.owner = id;
		}
		
		// Return object
        return instance_create_depth(_pos_x, _pos_y, depths.effects, _object, _var_struct);
    }
	return noone;
}

function gui_create(_object, _var_struct={}) {
	// Return value
	if (!instance_exists(_object)) {
		return instance_create_depth(0, 0, depths.gui, _object, _var_struct);
	}
	return noone;
}

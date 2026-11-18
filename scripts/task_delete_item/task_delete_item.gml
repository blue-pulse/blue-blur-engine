function task_delete_item(_resource) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Variables
	var _ops = global.async_operations;
	var _amount_ops = array_length(_ops);
	
	// Search task
	for (var _i = 0; _i < _amount_ops; ++_i) {
		if (_ops[_i].resource == _resource) {
			array_delete(global.async_operations, _i, 1);
			break;
		}
	}
}

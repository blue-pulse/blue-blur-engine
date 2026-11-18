function task_set_status(_resource, _status) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Variables
	var _ops = global.async_operations;
	var _amount_ops = array_length(_ops);
	
	// Search task
	for (var _i = 0; _i < _amount_ops; ++_i) {
		var _item = _ops[_i];
		if (_item.resource == _resource) {
			_item.status = _status;
			break;
		}
	}
}

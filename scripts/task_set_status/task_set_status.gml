function task_set_status(_resource, _status) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Variables
	var ops = async_queue;
	var amount_ops = array_length(ops);
	
	// Search task
	for (var i = 0; i < amount_ops; ++i) {
		var item = ops[i];
		if (item.resource == _resource) {
			item.status = _status;
			break;
		}
	}
}

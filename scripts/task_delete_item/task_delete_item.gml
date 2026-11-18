function task_delete_item(_resource) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Variables
	var ops = global.async_operations;
	var amount_ops = array_length(ops);
	
	// Search task
	for (var i = 0; i < amount_ops; ++i) {
		if (ops[i].resource == _resource) {
			array_delete(global.async_operations, i, 1);
			break;
		}
	}
}

function task_add_item(_resource, _status) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Create loading animation
	gui_create(obj_loading);
	
	// Push item
	array_push(global.async_operations, new Task(_resource, _status));
}

function instance_create_singleton(object) {
	return instance_create_depth(0, 0, orders.controller, object);
}

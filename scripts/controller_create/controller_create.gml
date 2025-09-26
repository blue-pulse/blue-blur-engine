function controller_create(object) {
	return instance_create_depth(0, 0, queue.controller, object);
}

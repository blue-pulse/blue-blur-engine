function instance_create_vfx(pos_x, pos_y, object, overlap=false) {
	if (overlap or !instance_exists(object)) {
        return instance_create_depth(pos_x, pos_y, orders.effects, object);
    }
}

function instance_nearest_nth(pos_x, pos_y, object, number) {
	// Variables
	var	instance = noone;
	var	priority = ds_priority_create();
	var	i = 0;
	
	// Logic
	with (object) {
		if (self == object) then continue;
		ds_priority_add(priority, id, distance_to_point(pos_x, pos_y));
		++i;
	}
	
	var amount = min(i, max(1, number));
	repeat (amount) {
		instance = ds_priority_delete_max(priority);
	}
	
	// Destroy queue
	ds_priority_destroy(priority);
	
	// Return instance
	return instance;
}

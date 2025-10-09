// Variables
var mean_node = -1;
var base_tension = 0;

// Get player position
with (Player) {
	if (ground_id == other.id) {
		var left_offset = other.bbox_left;
		var width = other.sprite_width;
		mean_node = clamp(x - left_offset, 0, width) / width;
	}
}

// Calculate height
if (mean_node != -1) {
	ratio = mean_node;
	base_tension = max_tension * dsin(ratio * 180);
}

// Set height
if (tension != base_tension) {
	var new_tension = lerp(tension, base_tension, 0.2);
	tension = floor(new_tension);
	y = ystart + tension;
}

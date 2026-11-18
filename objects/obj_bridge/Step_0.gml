// Variables
var _mean_node = -1;
var _base_tension = 0;

// Get player position
with (obj_player) {
	if (ground_id == other.id) {
		var _left_offset = other.bbox_left;
		var _width = other.sprite_width;
		_mean_node = clamp(x - _left_offset, 0, _width) / _width;
	}
}

// Calculate height
if (_mean_node != -1) {
	ratio = _mean_node;
	_base_tension = max_tension * dsin(ratio * 180);
}

// Set height
if (tension != _base_tension) {
	var _new_tension = lerp(tension, _base_tension, 0.2);
	tension = floor(_new_tension);
	y = ystart + tension;
}

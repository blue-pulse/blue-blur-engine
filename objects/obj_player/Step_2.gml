// Update animation
var index = struct_get_from_hash(animations, variable_get_hash(animation_index));
if (timeline_index != index)
{
	timeline_index = index;
	timeline_position = 0;
}

// Update trail alpha
var alpha_val = (animation_index == "spin" and (x != xprevious or y != yprevious));
array_delete(trail_alpha, 0, 1);
array_push(trail_alpha, alpha_val);

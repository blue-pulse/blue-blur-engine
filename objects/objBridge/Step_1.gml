/// @description Update height
var mean_node = -1;

// Get bridge position
with (objPlayer)
{
	if (ground_id == other.id)
	{
		mean_node = clamp(x - other.bbox_left, 0, other.sprite_width) / other.sprite_width;
	}
}

// Calculate height
var base_tension = 0;
if (mean_node != -1)
{
	ratio = mean_node;
	base_tension = max_tension * dsin(ratio * 180);
}
if (tension != base_tension)
{
	tension = lerp(tension, base_tension, 0.2) div 1;
	y = ystart + tension;
}
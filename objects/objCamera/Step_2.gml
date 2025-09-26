/// @description Update view position

// Get view position
var view_x = camera_get_view_x(CAMERA_ID);
var view_y = camera_get_view_y(CAMERA_ID);

// Calculate offset from view center
var ox = x - (view_x + SCREEN_WIDTH * 0.5);
var oy = y - (view_y + SCREEN_HEIGHT * 0.5);

// Apply panning offsets
if (panning_ox != 0 or panning_oy != 0)
{
	var sine = dsin(gravity_direction);
	var cosine = dcos(gravity_direction);
	ox += (cosine * panning_ox) + (sine * panning_oy);
	oy += (-sine * panning_ox) + (cosine * panning_oy);
}

// Limit to specified borders
var x_border = 8;
var y_border = 32;
ox = max(abs(ox) - x_border, 0) * sign(ox);
if (not ground_mode) oy = max(abs(oy) - y_border, 0) * sign(oy);

// Limit movement speed
var x_speed_cap = 16 * (alarm[0] == -1);
var y_speed_cap = min(6 + abs(y - yprevious), 16);
if (abs(ox) > x_speed_cap) ox = x_speed_cap * sign(ox);
if (abs(oy) > y_speed_cap) oy = y_speed_cap * sign(oy);

// Move the view
if (ox != 0 or oy != 0)
{
	var nx = clamp(view_x + ox, bound_left, bound_right - SCREEN_WIDTH);
	var ny = clamp(view_y + oy, bound_top, bound_bottom - SCREEN_HEIGHT);
	camera_set_view_pos(CAMERA_ID, nx, ny);
}
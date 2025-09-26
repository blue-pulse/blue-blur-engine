/// @description Initialize
image_speed = 0;

// Bounds
bound_left = 0;
bound_top = 0;
bound_right = room_width;
bound_bottom = room_height;
ground_mode = true;

// Panning
panning_ox = 0;
panning_oy = 0;

// Center the view
var ox = clamp(x - SCREEN_WIDTH * 0.5, bound_left, bound_right - SCREEN_WIDTH);
var oy = clamp(y - SCREEN_HEIGHT * 0.5, bound_top, bound_bottom - SCREEN_HEIGHT);
camera_set_view_pos(CAMERA_ID, ox, oy);
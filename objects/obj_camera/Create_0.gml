// Basic
enabled = true;
view_x = x;
view_y = y;
view_width = WIDTH;
view_height = HEIGHT;
target = noone;
target_x = 0;
target_y = 0;

// Extended camera
shift_value = 64;
shift_speed = floor(shift_value / 32);
scroll_delay = 0;
overview_delay = 0;
overview_offset = 0;
extended_offset = 0;
smooth_lerp = 0.3;

// Shake
shake_power = 0;
shake_timer = 0;

// Zoom
zoom_amount = 1;
zoom_timer = 0;
zoom_lerp = 0.15;

// Enable view
view_enabled = true;
view_visible[0] = true;
var view = camera_create_view(view_x, view_y, view_width, view_height);
view_set_camera(0, view);

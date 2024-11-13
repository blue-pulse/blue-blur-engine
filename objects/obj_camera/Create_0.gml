// View
def_width = global.width;
def_height = global.height;

// Position
target = self;
disp_x = 0;
disp_y = 0;
smooth_lerp = 0.3;

// Shake
shake_power = 0;
shake_timer = 0;

// Zoom
zoom_amount = 1;
zoom_timer = 0;
zoom_lerp = 0.15;

// Enable views
view_enabled = true;
view_visible[0] = true;

// Create view
view = camera_create_view(x, y, def_width, def_height);
view_set_camera(0, view);

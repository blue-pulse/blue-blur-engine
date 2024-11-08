// View
width = global.width;
height = global.height;

// Position
target = self;
disp_x = 0;
disp_y = 0;
lerp_index = 0.3;

// Shake
shake_timer = 0;
shake_index = 0;

// Zoom
zoom_amount = 0;

// Enable views
view_enabled = true;
view_visible[0] = true;

// Create view
view = camera_create_view(x, y, width, height);
view_set_camera(0, view);

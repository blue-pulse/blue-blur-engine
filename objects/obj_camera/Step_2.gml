// Get current camera position
var pos_x = camera_get_view_x(view);
var pos_y = camera_get_view_y(view);
var view_width = camera_get_view_width(view);
var view_height = camera_get_view_height(view);

// Set target camera position
var target_x = (target.x + disp_x) - view_width / 2;
var target_y = (target.y + disp_y) - view_height / 2;

// Smoothly move the camera to the target position
pos_x = lerp(pos_x, target_x, lerp_index);
pos_y = lerp(pos_y, target_y, lerp_index);

// Shaking
if (shake_timer > 0) {
	var shake = power(shake_timer, 2) * shake_index;
	pos_x += random_range(-shake, shake);
	pos_y += random_range(-shake, shake);
	shake_timer--;
}

// Zooming
if (zoom_amount != 0) {
	// Variables
	var zoom = zoom_amount * lerp_index;
	var zoom_width = view_width * zoom;
	var zoom_height = view_height * zoom;
	
	// Add to size
	view_width += zoom_width;
	view_height += zoom_height;
	
	// Position
	pos_x -= zoom_width / 2;
	pos_y -= zoom_height / 2;
}

// Clamp the camera to room bounds
pos_x = clamp(pos_x, 0, room_width - view_width);
pos_y = clamp(pos_y, 0, room_height - view_height);

// Apply camera position
camera_set_view_pos(view, pos_x, pos_y);
camera_set_view_size(view, view_width, view_height);

/// @description Instance culling

// Deactivate instances
instance_deactivate_object(objDeactivable);

// Activate instances within the view
var view_left = camera_get_view_x(CAMERA_ID) - CAMERA_PADDING;
var view_top = camera_get_view_y(CAMERA_ID) - CAMERA_PADDING;
var view_right = SCREEN_WIDTH + CAMERA_PADDING * 2;
var view_bottom = SCREEN_HEIGHT + CAMERA_PADDING * 2;
instance_activate_region(view_left, view_top, view_right, view_bottom, true);

// Activate instances around the player
with (objPlayer)
{
	if (not in_view(id, CAMERA_PADDING))
	{
		instance_activate_region(x - CAMERA_PADDING, y - CAMERA_PADDING, CAMERA_PADDING * 2, CAMERA_PADDING * 2, true);
	}
}
/// @description Fullscreen / window scale
if (input_check_pressed("resize"))
{
	if (++window_scale == 4)
	{
		window_scale = 0;
		window_set_fullscreen(true);
		surface_resize(application_surface, display_get_width(), display_get_height());
	}
	else
	{
		if (window_scale == 1) window_set_fullscreen(false);
		window_set_size(SCREEN_WIDTH * window_scale, SCREEN_HEIGHT * window_scale);
		surface_resize(application_surface, SCREEN_WIDTH * window_scale, SCREEN_HEIGHT * window_scale);
		window_center();
	}
}
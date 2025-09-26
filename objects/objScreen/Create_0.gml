/// @description Initialize
window_scale = 1;

// Resize window
window_set_size(SCREEN_WIDTH, SCREEN_HEIGHT);
surface_resize(application_surface, SCREEN_WIDTH, SCREEN_HEIGHT);
display_set_gui_size(SCREEN_WIDTH, SCREEN_HEIGHT);
window_center();
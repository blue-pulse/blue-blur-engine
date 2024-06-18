// Set application parameters
surface_resize(application_surface, width, height);

// Set window properties
verify_screen_resolution();
set_window_properties();

// Apply some GPU magic that will increase game speed
surface_depth_disable(true);
gpu_set_alphatestenable(true);
gpu_set_alphatestref(0);
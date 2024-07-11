// Set application parameters
surface_resize(application_surface, Screen.width, Screen.height);

// Set screen properties
screen_verify_resolution();
screen_set_properties();

// Apply some GPU magic that will increase game speed
surface_depth_disable(true);
gpu_set_alphatestenable(true);
gpu_set_alphatestref(0);

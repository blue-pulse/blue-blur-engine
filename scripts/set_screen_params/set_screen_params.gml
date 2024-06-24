// Set application parameters
surface_resize(application_surface, width, height);

// Set window properties
window_verify_resolution();
window_set_properties();

// Apply some GPU magic that will increase game speed
surface_depth_disable(true);
gpu_set_alphatestenable(true);
gpu_set_alphatestref(0);
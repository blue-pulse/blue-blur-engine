// Start package
show_debug_message("EasyFade: Welcome to EasyFade by Blue Pulse!");

// Globals
global.__fade_exit_code = FADE_EX_SUCCESS;

// Macros
#macro FADE_H display_get_gui_height()
#macro FADE_W display_get_gui_width()
#macro FADE_EX_SUCCESS 0
#macro FADE_EX_SIGKILL 137
#macro is_faiding instance_find(_fade_controller, 0)

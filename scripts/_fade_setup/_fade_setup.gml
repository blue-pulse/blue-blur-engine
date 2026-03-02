// Start package
show_debug_message("EasyFade: Welcome to EasyFade by Blue Pulse!");

// Globals
global.fade_controller = noone;

// Macros
#macro FADE_H display_get_gui_height()
#macro FADE_W display_get_gui_width()
#macro is_faiding instance_exists(global.fade_controller)

// Start package
show_debug_message("EasyFade: Welcome to EasyFade by Blue Pulse!");

// Macros
#macro is_fading instance_find(_fade_controller, 0)
#macro FADE_H display_get_gui_height() + 1
#macro FADE_W display_get_gui_width() + 1
#macro FADE_DEPTH -5120
enum FADE_EXIT { SUCESS = 0, SIGKILL = 137 }

// Globals
global.__fade_exit_code = FADE_EXIT.SUCESS;

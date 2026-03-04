// Parameters
color ??= c_black;
duration ??= 0;
target_room ??= noone;
silent_fading ??= false;

// Variables
timer = 0;
alpha = 0;
width = FADE_W;
height = FADE_H;
start_fade = true;

// Early exit
if (instance_number(_fade_controller) > 1) {
	// Debug messages
	show_debug_message("EasyFade: [ERROR] Another fade is already in progress!");
	show_debug_message("EasyFade: [INFO] Killing instance: " + string(id) + "...");
	
	// Set exit code
	global.__fade_exit_code = FADE_EX_SIGKILL;
	
	// Kill instance
	instance_destroy();
}

function dev_command_toggle_hud() {
	// Early exit
	if (!instance_exists(obj_hud)) {
		return;
	}
	
	// Toggle HUD
	hud_set_visibility(!hud_get_visibility());
}

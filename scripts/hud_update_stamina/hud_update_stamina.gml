function hud_update_stamina() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Move items
	var stamina_target = (viewable) ? (stamina_icon_xend) : (stamina_icon_xstart);
	if (stamina_icon_x != stamina_target) {
		// Variables
	    var item_speed = stamina_speed * sign(stamina_target - stamina_icon_x);
		stamina_tint = c_gray;
		stamina_value = 0;
		
		// Move icon
	    stamina_icon_x = clamp(
	        stamina_icon_x + item_speed,
	        min(stamina_icon_xstart, stamina_icon_xend),
	        max(stamina_icon_xstart, stamina_icon_xend)
	    );
	}
	
	// When visible
	else if (stamina_icon_x == stamina_icon_xend) {
		stamina_tint = c_white;
		stamina_value = target.stamina * 1.4;
	}
}

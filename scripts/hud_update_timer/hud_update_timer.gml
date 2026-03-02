function hud_update_timer() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Move items
	var time_target = (viewable) ? (time_icon_xend) : (time_icon_xstart);
	if (time_icon_x != time_target) {
		// Variables
	    var item_speed = time_speed * sign(time_target - time_icon_x);
		time_tint = c_gray;
		update_time = false;
		
		// Move icon
	    time_icon_x = clamp(
	        time_icon_x + item_speed,
	        min(time_icon_xstart, time_icon_xend),
	        max(time_icon_xstart, time_icon_xend)
	    );
		
		// Move text
	    time_text_x = clamp(
	        time_text_x + item_speed,
	        min(time_text_xstart, time_text_xend),
	        max(time_text_xstart, time_text_xend)
	    );
	}
	
	// When visible 
	else if (time_icon_x == time_icon_xend) {
		time_tint = c_white;
		update_time = true
		time_text = hud_get_time();
	}
}

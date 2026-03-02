function hud_update_rings() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Move items
	var rings_target = (viewable) ? (rings_icon_xend) : (rings_icon_xstart);
	if (rings_icon_x != rings_target) {
		// Variables
	    var item_speed = rings_speed * sign(rings_target - rings_icon_x);
		rings_tint = c_gray;
		
		// Move icon
	    rings_icon_x = clamp(
	        rings_icon_x + item_speed,
	        min(rings_icon_xstart, rings_icon_xend),
	        max(rings_icon_xstart, rings_icon_xend)
	    );
		
		// Move text
	    rings_text_x = clamp(
	        rings_text_x + item_speed,
	        min(rings_text_xstart, rings_text_xend),
	        max(rings_text_xstart, rings_text_xend)
	    );
	} 
	
	// When visible 
	else if (rings_icon_x == rings_icon_xend) {
		rings_tint = c_white;
		rings_text = int_to_text(target.rings, 3);
	}
}

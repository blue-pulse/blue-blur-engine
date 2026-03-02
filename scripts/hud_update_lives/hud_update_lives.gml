function hud_update_lives() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Move items
	var life_target = (viewable) ? (life_icon_xend) : (life_icon_xstart);
	if (life_icon_x != life_target) {
		// Variables
	    var item_speed = life_speed * sign(life_target - life_icon_x);
		life_tint = c_gray;
		
		// Move icon
	    life_icon_x = clamp(
	        life_icon_x + item_speed,
	        min(life_icon_xstart, life_icon_xend),
	        max(life_icon_xstart, life_icon_xend)
	    );

		// Move text
	    life_text_x = clamp(
	        life_text_x + item_speed,
	        min(life_text_xstart, life_text_xend),
	        max(life_text_xstart, life_text_xend)
	    );
	}
	
	// When visible
	else if (life_icon_x == life_icon_xend) {
		life_tint = c_white;
		life_text = int_to_text(global.lives, 2);
	}
}

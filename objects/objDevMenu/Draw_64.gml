/// @description Display player data
draw_set_halign(fa_right);
draw_set_font(objResources.font_debug);
draw_text_transformed(SCREEN_WIDTH - 16, 9, player_data, 0.7, 0.7, 0);
draw_set_halign(fa_left);
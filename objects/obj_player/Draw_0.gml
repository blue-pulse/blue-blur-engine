// Trail
player_draw_trail(c_blue);

// Character sprite
draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, 1, round(image_angle / 45) * 45, c_white, image_alpha);
snip_draw_debug(x-30,y+40)
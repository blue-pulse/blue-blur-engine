// Allow interpolation
gpu_set_texfilter(true);

// Draw sprite
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1);

// Disable interpolation
gpu_set_texfilter(false);

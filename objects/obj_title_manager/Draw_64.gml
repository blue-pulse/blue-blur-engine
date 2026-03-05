// Allow interpolation on logo
gpu_set_texfilter(true);
draw_sprite_ext(spr_logo, 0, logo_x, logo_y, logo_scale, logo_scale, 0, c_white, 1);
gpu_set_texfilter(false);

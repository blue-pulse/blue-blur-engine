/// @description Draw reticle
draw_sprite_ext(sprite_index, 0, x, y, circle_scale, circle_scale, round(circle_angle / 23) * 23, c_white, image_alpha);
draw_sprite_ext(sprite_index, 1, x, y, arrow_scale, arrow_scale, round(arrow_angle / 23) * 23, c_white, image_alpha);
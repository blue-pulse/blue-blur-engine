// Set parameters
x = floor(pos_x);
y = floor(pos_y);
image_xscale = facing;
image_angle = angle;

// Draw player
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, image_angle, c_white, image_alpha);
draw_ellipse(x + radius_x, y, x, y + radius_y, true);
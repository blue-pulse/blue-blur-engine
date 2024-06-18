// Set parameters
x = floor(pos_x);
y = floor(pos_y);
image_angle = visual_angle;

// Draw player
draw_circle(x,y,radius_x,true);
draw_circle(x,y,radius_y,true);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, image_angle, c_white, image_alpha);
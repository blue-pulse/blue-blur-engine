// Setup
x = floor(pos_x);
y = floor(pos_y);
image_xscale = facing;
image_angle = rotation;
image_alpha = opacity;

// Draw player
draw_self();
draw_line(x, y, x+radius_x, y);
draw_line(x, y, x-radius_x, y);
draw_line(x, y, x, y+radius_y);
draw_line(x, y, x, y-radius_y);
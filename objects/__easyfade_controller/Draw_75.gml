// Start fade
draw_set_alpha(__alpha);
draw_set_color(__color);
draw_rectangle(0, 0, __width, __height, false);

// Restore changes
draw_set_alpha(1);
draw_set_color(c_white);

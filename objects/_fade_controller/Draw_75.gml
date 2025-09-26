// Start fade
draw_set_alpha(alpha);
draw_set_color(color);
draw_rectangle(0, 0, width, height, false);

// Restore changes
draw_set_alpha(1);
draw_set_color(c_white);

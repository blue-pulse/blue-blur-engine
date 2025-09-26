/// @description Render game over
var ox = max(alarm[0] * 16, 0);
draw_sprite(sprGameOver, image_index, SCREEN_WIDTH * 0.5 - 40 - ox, SCREEN_HEIGHT * 0.5);
draw_sprite(sprGameOver, 2, SCREEN_WIDTH * 0.5 + 40 + ox, SCREEN_HEIGHT * 0.5);
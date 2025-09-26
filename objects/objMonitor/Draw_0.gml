/// @description Draw monitor
var timer = objScreen.image_index;
draw_sprite(sprite_index, timer div 2, x, y); // Box and static
if (timer mod 6 > 1) draw_sprite(sprMonitorIcon, icon_index, x, y - 5); // Icon
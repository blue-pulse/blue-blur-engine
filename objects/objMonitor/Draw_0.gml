/// @description Draw monitor
var timer = global.ticks;
draw_sprite(sprite_index, timer div 2, x, y); // Box and static
if (timer mod 6 > 1) draw_sprite(sprMonitorIcon, icon_index, x, y - 5); // Icon
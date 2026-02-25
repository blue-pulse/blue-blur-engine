// Parameters
owner ??= noone;
explosion_timer ??= 0;

// Variables
depth = depths.effects;
sprite_index = spr_metal_scraps;
image_index = random_range(0, 5);
image_speed = 0;
hspeed = random_range(-3, 3);
vspeed = random_range(-5, -3);
gravity = 0.23;

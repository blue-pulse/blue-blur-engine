// Parameters
owner ??= noone;
dir ??= image_xscale;
angle ??= image_angle;

// Variables
depth = depths.player;
sprite_index = spr_spindash_dust;
image_xscale = sign(dir);
image_angle = angle;
x = floor(x);
y = floor(y);

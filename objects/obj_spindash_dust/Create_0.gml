// Variables
sprite_index = spr_spindash_dust;
x = floor(x);
y = floor(y);

// Parameters
owner ??= noone;
dir ??= image_xscale;
angle ??= image_angle;

// Set direction
image_xscale = sign(dir);

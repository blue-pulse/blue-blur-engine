// Object parameters
image_angle = Player.image_angle;
image_speed = 1.5;
image_xscale = sign(Player.image_xscale);
sprite_index = spr_spindash_dust;

// Update position
x = floor(Player.pos_x);
y = floor(Player.pos_y + Player.radius_y);	
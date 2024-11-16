// Inherit the parent event
event_inherited();

// Variables
depth = queue.enemies;
pos_x = 0;
pos_y = 0;
dir = sign(image_xscale);
hor_speed = 0;
ver_speed = 0;
angle = 0;
plane = 0;
snd_hit = [snd_enemy_hit_a, snd_enemy_hit_b, snd_enemy_hit_c];
states_that_hurt = [states.roll, states.jump, states.land, states.slide, states.spindash, states.stomp];
instance_set_hitbox(10, 10);

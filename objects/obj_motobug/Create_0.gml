// Inherit the parent event
event_inherited();

// Particles
vfx_smoke = part_type_create();
part_type_sprite(vfx_smoke, spr_motobug_smoke, true, true, false);
part_type_life(vfx_smoke, 16, 16);

// Parameters
movement_speed = 1;
movement_dist = 60;

// Variables
hspeed = movement_speed * dir;
vspeed = 0;
state = 0;
smoke_timer = 0;
left_goal = xstart - movement_dist;
right_goal = xstart + movement_dist;

// Animations
anim_attack = animation_create(spr_motobug_attack);
anim_turn = animation_create(spr_motobug_turn);
animation_play(anim_attack);

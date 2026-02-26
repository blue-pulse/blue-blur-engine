// Inherit the parent event
event_inherited();

// Script
reaction_index = player_reaction_monitor;

// Particles
vfx_explosion = part_type_create();
part_type_sprite(vfx_explosion, spr_monitor_explosion, true, true, false);
part_type_life(vfx_explosion, 15, 15);

// Variables
depth = depths.backstage;
item = items.none;

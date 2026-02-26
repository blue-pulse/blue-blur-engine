// Inherit the parent event
event_inherited();

// Variables
depth = depths.backstage;
sprite_index = spr_bridge_log;
max_tension = 16;
node_width = sprite_get_width(sprite_index);
ratio = 0;
semisolid = true;
tension = 0;

// Post parameters
post_sprite = spr_bridge_post;
post_height = y - 13;
post_left_pos = bbox_left - 28;
post_right_pos = bbox_right + 28;

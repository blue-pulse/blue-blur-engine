// Variables
commands = dev_define_commands();

// Remember what the commands change in the view
camera_target_before = instance_exists(obj_camera) ? camera_get_target() : noone;
hud_visible_before = instance_exists(obj_hud) ? hud_get_visibility() : true;

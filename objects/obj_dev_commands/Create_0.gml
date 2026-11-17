// Variables
commands = dev_setup_commands();

// Remember what the commands can change in the view
camera_target_before = instance_exists(Camera) ? camera_get_target() : noone;
hud_visible_before = instance_exists(obj_hud) ? hud_get_visibility() : true;

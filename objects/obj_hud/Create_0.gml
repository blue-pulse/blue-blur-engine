// Parameters
target ??= noone;
show_time ??= false;
show_rings ??= false;
show_life ??= false;
show_stamina ??= false;

// Variables
depth = depths.gui;
sprite_index = noone;
font = target.data_hud.font;
margin = 15;
viewable = true;

// Time
time_icon = spr_hud_time;
time_icon_xstart = -sprite_get_width(time_icon) - margin;
time_icon_xend = 15;
time_icon_x = time_icon_xstart;
time_icon_y = 15;

time_text = hud_get_timer();
time_text_xstart = -string_width(time_text) - margin;
time_text_xend = 40;
time_text_x = time_text_xstart;
time_text_y = 20;

time_speed = 6;
time_tint = c_gray;
update_time = false;

// Rings
rings_icon = spr_hud_rings;
rings_icon_xstart = -sprite_get_width(rings_icon) - margin;
rings_icon_xend = 15;
rings_icon_x = rings_icon_xstart;
rings_icon_y = 45;

rings_text = int_to_text(target.rings, 3);
rings_text_xstart = -string_width(rings_text) - margin;
rings_text_xend = 40;
rings_text_x = rings_text_xstart;
rings_text_y = 48;

rings_speed = 4.25;
rings_tint = c_gray;

// Lives
life_icon = target.data_hud.icon;
life_icon_xstart = WIDTH + sprite_get_width(life_icon) + margin;
life_icon_xend = WIDTH - 70;
life_icon_x = life_icon_xstart;
life_icon_y = 15;

life_text = int_to_text(global.lives, 2);
life_text_xstart = WIDTH + string_width(life_text) + margin * 5;
life_text_xend = WIDTH - 40;
life_text_x = life_text_xstart;
life_text_y = 20;

life_speed = 6;
life_tint = c_gray;

// Stamina
stamina_icon = spr_hud_stamina
stamina_icon_xstart = -sprite_get_width(stamina_icon) - margin;
stamina_icon_xend = 15;
stamina_icon_x = stamina_icon_xstart;
stamina_icon_y = HEIGHT - 30;

stamina_color_0 = target.data_hud.colors[0];
stamina_color_1 = target.data_hud.colors[1];
stamina_value = 0;
stamina_value_a_x = 22;
stamina_value_a_y = HEIGHT - 22.5;
stamina_value_b_x = 23;
stamina_value_b_y = HEIGHT - 21.5;

stamina_speed = 9;
stamina_tint = c_gray;

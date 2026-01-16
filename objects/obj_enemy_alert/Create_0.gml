// Variables
depth = depths.gui;
sprite_index = spr_enemy_alert;
timer = 30;

// Parameters
owner ??= noone;
dir ??= sign(image_xscale);
hor_offset ??= 0;
ver_offset ??= 0;

// Sound
sfx_alert = audio_play_sfx(snd_enemy_alert, REPLACE);

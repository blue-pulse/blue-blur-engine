// Parameters
owner ??= noone;
target ??= noone;

// Variables
depth = depths.gui;
sprite_index = spr_reticle;
image_alpha = 0;
image_speed = 0;
arrow_angle = 45;
arrow_scale = 8;
circle_angle = 0;
circle_scale = 5;
scale_limit = 0.8;

// Sound
audio_play_sfx(snd_player_reticle, REPLACE);

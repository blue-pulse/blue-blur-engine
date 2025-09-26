/// @description Initialize
image_speed = 0;

// State machine
state = 1;

// Name tag
name = objStage.name;
act = objStage.act;

// Setpieces
backdrop_offset = 0;
band_offset = SCREEN_WIDTH;
fold_width = -sprite_get_width(sprTitleCardFold);
banner_offset = fold_width;

// Labels
var screen_offset = SCREEN_WIDTH * 0.1;
draw_set_font(objResources.font_title);
name_ox = SCREEN_WIDTH - string_width(name) - screen_offset;
zone_ox = SCREEN_WIDTH - string_width("ZONE") - sprite_get_width(sprActNumber) - screen_offset;
label_offset = SCREEN_WIDTH;
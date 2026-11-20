// Variables
depth = depths.minimum;
sprite_index = spr_loading;
x = WIDTH - 40;
y = HEIGHT - 30;
visible = true;
is_shown = false;
is_holding = false;
hold_steps = ceil(INDICATOR_MIN_TIME * MAX_FPS / MS_PER_SECOND);

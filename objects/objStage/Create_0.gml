/// @description Initialize
image_speed = 0;

// State
started = false; // The player cannot move until the stage has started
finished = false; // When the stage has ended, this is set so all game values are reset properly

// Timing
timer_enabled = false;
stage_time = 0;
time_limit = 35999; // 10 minutes
time_over = false;
reset_time = 0;

// Stage data
name = "";
act = 0;
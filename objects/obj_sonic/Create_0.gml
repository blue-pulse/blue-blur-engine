// Inherit the parent event
event_inherited();

// Specific character functions
play_jump_anim = sonic_play_jump;
play_roll_anim = sonic_play_roll;
play_run_anim = sonic_play_run;
begin_jump_action = sonic_begin_homing;

// Create animations
sonic_init_animations();
sonic_init_transitions();

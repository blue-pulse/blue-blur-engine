// Inherit the parent event
event_inherited();

// Update config
sonic_init_config();
sonic_init_animations();
sonic_init_transitions();

// Specific character functions
player_animation_jump = sonic_animation_jump;
player_animation_roll = sonic_animation_roll;
player_animation_run = sonic_animation_run;
player_routine_midair = sonic_routine_homing;

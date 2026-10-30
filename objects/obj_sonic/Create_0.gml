// Inherit the parent event
event_inherited();

// Update config
sonic_init_config();
sonic_init_animations();

// Specific character functions
player_routine_midair = sonic_routine_homing;

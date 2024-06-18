// Set variables
global.delta_multiplier = min((delta_time * DESIRED_FPS) / SCALE_FACTOR, MAX_DELTA);
global.delta_override = 1//global.delta_multiplier * !paused;
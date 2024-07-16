// Update delta time factor
global.delta_factor = min((EXPECTED_DELTA * delta_time), MAX_LAG);
print(game_get_speed(gamespeed_fps));
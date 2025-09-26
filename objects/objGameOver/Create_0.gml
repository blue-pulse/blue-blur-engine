/// @description Initialize
image_speed = 0;
image_index = (objStage.time_over and objGameData.player_lives > 0); // Determine game over type

// Music
audio_enqueue_bgm(bgmGameOver, 4, false);

// Begin movement alarm
alarm[0] = (256 + SCREEN_WIDTH * 0.5) * 0.0625;
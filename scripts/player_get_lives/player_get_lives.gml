function player_get_lives(amount) {
	global.lives = min(global.lives + amount, 99);
	//audio_play_jingle(bgmLife);
}

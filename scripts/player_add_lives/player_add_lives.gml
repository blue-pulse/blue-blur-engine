function player_add_lives(amount) {
	global.lives = min(global.lives + amount, 99);
	//audio_play_jingle(bgmLife);
}

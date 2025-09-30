function player_get_lives(amount) {
	objGameData.player_lives = min(objGameData.player_lives + amount, 99);
	audio_play_jingle(bgmLife);
}

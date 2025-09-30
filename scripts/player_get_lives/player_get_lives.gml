
/// @description Increases the player's life count by the given amount.
/// @param {Real} amount Number of lives to give.
function player_get_lives(amount)
{
	objGameData.player_lives = min(objGameData.player_lives + amount, 99);
	audio_play_jingle(bgmLife);
}
/// @description Handles the player's condition upon taking damage.
/// @param {Real} obj Object or instance the player should recoil from.
/// @returns {Bool} Whether or not the player's state should be aborted.
function player_get_hit(obj)
{
	// Abort if already invulnerable in any way
	if (state == player_is_hurt or recovery_time > 0 or invincibility_time > 0) return false;
	
	// Drop rings and recoil, if applicable
	if (objGameData.player_rings > 0)
	{
		player_drop_rings();
		player_is_hurt(-1);
		
		// Movement
		hor_speed = 2 * sign(x - obj.x);
		if (hor_speed == 0) hor_speed = 2;
		ver_speed = -4;
	}
	else player_is_dead(-1); // Otherwise, die
	return true;
}

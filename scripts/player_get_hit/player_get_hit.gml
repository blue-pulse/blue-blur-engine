function player_get_hit(object) {
	// Abort if already invulnerable in any way
	if (state == player_is_hurt or recovery_time > 0 or invincibility_time > 0) {
		return false;
	}
	
	// Drop rings and recoil
	if (objGameData.player_rings > 0) {
		player_drop_rings();
		player_is_hurt(-1);
		
		// Movement
		hor_speed = 2 * sign(x - object.x);
		if (hor_speed == 0) {
			hor_speed = 2;
		}
		ver_speed = -4;
	}
	
	// Die
	else {
		player_is_dead(-1); 
	}
	
	// Player was hit
	return true;
}

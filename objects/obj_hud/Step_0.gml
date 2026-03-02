// Early exit
if (!instance_exists(target) or is_faiding) {
	exit;
}

// Disable when player is dead
if (viewable and target.state == player_state_death) {
	viewable = false;
}

// Move time
if (show_time) {
	hud_update_timer();
}

// Move rings
if (show_rings) {
	hud_update_rings();
}

// Move life
if (show_life) {
	hud_update_lives();
}

// Move stamina
if (show_stamina) {
	hud_update_stamina();
}

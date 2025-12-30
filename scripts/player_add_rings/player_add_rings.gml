function player_add_rings(amount) {
	var total = rings + amount;
	
	// Get lives
	if (total <= 999) {
		var change = (rings mod 100) + amount;
		if (change >= 100) {
			player_add_lives(change div 100);
		}
	}
	
	// Get rings
	rings = min(total, 999);
}

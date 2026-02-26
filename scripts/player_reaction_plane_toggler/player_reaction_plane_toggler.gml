function player_reaction_plane_toggler(object) {
	// Flip plane if on ground
	if (is_grounded) {
		plane = (object.dir != sign(x - xprevious));
	}
	
	// Do not abort state
	return false;
}

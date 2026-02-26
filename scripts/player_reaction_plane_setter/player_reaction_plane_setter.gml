function player_reaction_plane_setter(object) {
	// Set plane according to scale
	plane = (object.image_xscale < 0);
	
	// Do not abort state
	return false;
}

function player_get_reaction(object, dir=undefined) {
	// Get reaction
	var reaction = object.reaction_index;
	
	// Early exit
	if (!reaction) {
		return false;
	}
	
	// Return reaction
	return (dir == undefined) ? reaction(object) : reaction(object, dir);
}

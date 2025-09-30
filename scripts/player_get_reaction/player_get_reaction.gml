function player_get_reaction(object, dir=undefined) {
	// Early exit
	var reaction = object.reaction_index;
	if (!reaction) {
		return false;
	}
	
	// Return reaction
	return (dir == undefined) ? reaction(object) : reaction(object, dir);
}

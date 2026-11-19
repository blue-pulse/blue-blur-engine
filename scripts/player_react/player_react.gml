function player_react(object, _dir=undefined) {
	// Early exit
	var reaction = object.reaction_index;
	if (reaction == noone) {
		return false;
	}
	
	// Return reaction
	return (_dir == undefined) ? reaction(object) : reaction(object, _dir);
}

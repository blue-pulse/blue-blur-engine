function player_reaction_bullet(object) {
	object.impacted = true;
	return player_receive_damage(object);
}

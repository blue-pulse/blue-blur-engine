function player_reaction_projectile(obj)
{
	// Take damage; abort state if successful
	return player_get_hit(obj);
}
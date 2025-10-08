function player_reaction_layer_set(obj)
{
	// Set layer according to scale
	plane = (obj.image_xscale < 0);
	
	// Do not abort state
	return false;
}

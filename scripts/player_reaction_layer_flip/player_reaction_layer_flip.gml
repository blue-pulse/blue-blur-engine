function player_reaction_layer_flip(obj)
{
	// Flip layer if on ground
	if (is_grounded) plane = (sign(obj.image_xscale) != sign(x - xprevious));
	
	// Do not abort state
	return false;
}
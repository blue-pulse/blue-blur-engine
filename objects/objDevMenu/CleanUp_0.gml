/// @description Cleanup
show_debug_overlay(false);

// Release player
with (objPlayer)
{
	if (state == player_is_debugging) player_is_falling(-1);
}

// Hide layer objects
with (objLayerFlip) visible = false;
with (objLayerSet) visible = false;
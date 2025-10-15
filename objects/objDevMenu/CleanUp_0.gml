/// @description Cleanup
show_debug_overlay(false);

// Release player
with (obj_player)
{
	if (state == player_is_debugging) player_state_airbone(-1);
}

// Hide layer objects
with (objLayerFlip) visible = false;
with (objLayerSet) visible = false;
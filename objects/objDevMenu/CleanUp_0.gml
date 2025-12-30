/// @description Cleanup
show_debug_overlay(false);

// Release player
with (obj_player)
{
	if (state == player_state_debug) {
		player_set_state(player_state_airbone);
	}
}

// Hide layer objects
with (objLayerFlip) visible = false;
with (objLayerSet) visible = false;
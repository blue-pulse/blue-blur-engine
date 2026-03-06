function game_set_checkpoint(struct) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Set checkpoint data
	if (variable_struct_exists(struct, "timecount")) then global.checkpoint.timecount = struct.timecount;
	if (variable_struct_exists(struct, "scoring")) then global.checkpoint.scoring = struct.scoring;
	if (variable_struct_exists(struct, "room_pos")) then global.checkpoint.room_pos = struct.room_pos;
	if (variable_struct_exists(struct, "hub_pos")) then global.checkpoint.hub_pos = struct.hub_pos;
}

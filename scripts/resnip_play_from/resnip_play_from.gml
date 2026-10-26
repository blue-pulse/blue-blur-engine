/// @func resnip_play_from(playback, snip, frame, [backward])
/// @desc Plays a snip on a playback now, starting on a chosen frame instead of its first or its last. The frame is entered like any other, so its loops and its script apply, and the playback starts at the beginning of that frame. Unlike resnip_play it looks for no transition and queues nothing, and like resnip_play it drops a queued snip. It replaces setting image_index by hand after changing sprite_index.
/// @param {Struct} playback The playback that plays it
/// @param {Struct} snip The snip to play
/// @param {Real} frame The frame of the snip to start on, counted from 0 at its first image
/// @param {Bool} [backward] Play down from that frame (default false)
/// @returns {Bool} True, like resnip_play
function resnip_play_from(_playback, _snip, _frame, _backward) {
	// Prevent a frame outside the snip
	__resnip_check_frame(_frame, _snip.count, "resnip_play_from");

	// Start it on that frame, with the default of backward read here because a default argument costs a write on YYC
	__resnip_playback_start(_playback, _snip, false, _backward ?? false, _frame);
	return true;
}

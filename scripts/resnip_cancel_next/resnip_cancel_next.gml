/// @func resnip_cancel_next(playback)
/// @desc Drops the snip queued by resnip_play. While a transition plays, the snip it leads to stays, since that is where the playback was going.
/// @param {Struct} playback The playback to change
function resnip_cancel_next(_playback) {
	_playback.__queue = undefined;
}

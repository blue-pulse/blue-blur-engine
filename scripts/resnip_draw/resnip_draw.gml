/// @func resnip_draw(playback, x, y)
/// @desc Draws the current frame of a playback. It works like draw_sprite and takes the sprite and the sub-image from the playback. It draws nothing if the playback plays no snip.
/// @param {Struct} playback The playback to draw
/// @param {Real} x The x position
/// @param {Real} y The y position
function resnip_draw(_playback, _x, _y) {
	var _snip = _playback.snip;
	if (_snip != undefined) {
		draw_sprite(_snip.sprite, resnip_frame_to_image(_snip, _playback.frame), _x, _y);
	}
}

/// @func resnip_draw_ext(playback, x, y, xscale, yscale, rot, col, alpha)
/// @desc Draws the current frame of a playback with scale, rotation, color and alpha. It works like draw_sprite_ext and takes the sprite and the sub-image from the playback. It draws nothing if the playback plays no snip.
/// @param {Struct} playback The playback to draw
/// @param {Real} x The x position
/// @param {Real} y The y position
/// @param {Real} xscale The horizontal scale
/// @param {Real} yscale The vertical scale
/// @param {Real} rot The angle in degrees
/// @param {Constant.Color} col The blend color
/// @param {Real} alpha The alpha from 0 to 1
function resnip_draw_ext(_playback, _x, _y, _xscale, _yscale, _rot, _col, _alpha) {
	var _snip = _playback.snip;
	if (_snip != undefined) {
		draw_sprite_ext(_snip.sprite, resnip_frame_to_image(_snip, _playback.frame), _x, _y, _xscale, _yscale, _rot, _col, _alpha);
	}
}

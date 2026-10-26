/// @func resnip_instance_sync(playback)
/// @desc Copies the sprite and the sub-image of a playback to the instance that calls it and sets image_speed to 0, so the mask, draw_self and any code that reads sprite_index and image_index follow the playback. Call it in the Step event after resnip_step. It adds no state to the instance.
/// @param {Struct} playback The playback to copy from
function resnip_instance_sync(_playback) {
	var _snip = _playback.snip;
	if (_snip != undefined) {
		sprite_index = _snip.sprite;
		image_index = resnip_frame_to_image(_snip, _playback.frame);
		image_speed = 0;
	}
}

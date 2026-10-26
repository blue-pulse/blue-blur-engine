/// @func resnip_frame_to_image(snip, frame)
/// @desc Converts a frame of a snip, counted from 0 at its first image, to a sub-image of its sprite, the number image_index and draw_sprite take. It has no native equivalent.
/// @param {Struct} snip The snip that holds the frame
/// @param {Real} frame The frame of the snip
/// @returns {Real} The sub-image of the sprite
function resnip_frame_to_image(_snip, _frame) {
	gml_pragma("forceinline");
	return _snip.first_image + _frame;
}

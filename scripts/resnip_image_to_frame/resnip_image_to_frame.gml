/// @func resnip_image_to_frame(snip, image)
/// @desc Converts a sub-image of the sprite of a snip to a frame of the snip, counted from 0 at its first image. It has no native equivalent.
/// @param {Struct} snip The snip that holds the image
/// @param {Real} image The sub-image of the sprite
/// @returns {Real} The frame of the snip
function resnip_image_to_frame(_snip, _image) {
	gml_pragma("forceinline");
	return _image - _snip.first_image;
}

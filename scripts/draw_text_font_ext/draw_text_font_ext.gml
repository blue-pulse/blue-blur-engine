/// Draws scaled and coloured text with a font and alignment, then restores the font and alignment to their defaults.
/// @param {Real} x Horizontal position
/// @param {Real} y Vertical position
/// @param {String} text Text to draw
/// @param {Asset.GMFont} font Font to draw with
/// @param {Constant.HAlign} hor_align Horizontal alignment
/// @param {Constant.VAlign} ver_align Vertical alignment
/// @param {Real} scale Scale of the text
/// @param {Constant.Colour} color Colour of the text
/// @param {Real} alpha Opacity of the text
function draw_text_font_ext(_x, _y, _text, _font, _hor_align, _ver_align, _scale, _color, _alpha) {
	// Draw text using font
	draw_set_font(_font);
	draw_set_halign(_hor_align);
	draw_set_valign(_ver_align);
	draw_text_transformed_colour(_x, _y, _text, _scale, _scale, 0, _color, _color, _color, _color, _alpha);

	// Restore font
	draw_set_font(-1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

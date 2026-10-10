/// Draws white text with a font and alignment, then restores the font and alignment to their defaults.
/// @param {Real} x Horizontal position
/// @param {Real} y Vertical position
/// @param {String} text Text to draw
/// @param {Asset.GMFont} font Font to draw with
/// @param {Constant.HAlign} [hor_align] Horizontal alignment
/// @param {Constant.VAlign} [ver_align] Vertical alignment
function draw_text_font(_x, _y, _text, _font, _hor_align=fa_left, _ver_align=fa_top) {
	return draw_text_font_ext(_x, _y, _text, _font, _hor_align, _ver_align, 1, c_white, 1);
}

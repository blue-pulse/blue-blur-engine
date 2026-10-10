/// Resets the opacity, colour, font, alignment and blend mode of drawing to their defaults.
function draw_reset() {
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(-1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	gpu_set_blendmode(bm_normal);
}

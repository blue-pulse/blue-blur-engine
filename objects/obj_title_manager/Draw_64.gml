// Allow interpolation on logo
gpu_set_texfilter(true);
draw_sprite_ext(spr_logo, 0, logo_x, logo_y, logo_scale, logo_scale, 0, c_white, 1);
gpu_set_texfilter(false);

// Set message
var message_text = "press any key";
switch (input_get_source()) {
	case vb_keyboard:
		message_text = "press enter key";
		break;
	case vb_gamepad:
		message_text = "press start button";
		break;
	case vb_touch:
		message_text = "touch to start";
		break;
}

// Draw message
draw_text_font_ext(message_x, message_y, message_text, font_black, fa_center, fa_middle, 1, c_white, message_alpha);

// Set message
var start_message = "press any key";
switch (input_get_source()) {
	case vb_keyboard:
		start_message = "press enter key";
		break;
	case vb_gamepad:
		start_message = "press start button";
		break;
	case vb_touch:
		start_message = "touch to start";
		break;
}

// Draw message
draw_font(x, y, start_message, font_black, 1, alpha, fa_center, fa_top);

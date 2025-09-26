/// @description Render title card

// Black backdrop
if (state < 2)
{
	draw_rectangle_color(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, c_black, c_black, c_black, c_black, false);
}

// Blue backdrop
if (backdrop_offset > 0)
{
	draw_rectangle_color(0, 0, SCREEN_WIDTH, backdrop_offset, c_blue, c_blue, c_blue, c_blue, false);
}

// Yellow band / game name
if (band_offset < SCREEN_WIDTH)
{
	draw_rectangle_color(band_offset, SCREEN_HEIGHT - 64, SCREEN_WIDTH, SCREEN_HEIGHT, c_yellow, c_yellow, c_yellow, c_yellow, false);
	draw_sprite(sprTitleCardGameName, 0, SCREEN_WIDTH * 0.5 + band_offset, SCREEN_HEIGHT - 55);
}

// Red banner
if (banner_offset > fold_width)
{
	draw_rectangle_color(fold_width, 0, banner_offset, SCREEN_HEIGHT, c_red, c_red, c_red, c_red, false);
	
	// Animate folds
	var fold_height = sprite_get_height(sprTitleCardFold);
	for (var oy = -8; oy < SCREEN_HEIGHT; oy += fold_height)
	{
		draw_sprite(sprTitleCardFold, 0, banner_offset, oy + 8 * (objScreen.image_index mod 32 < 16));
	}
}

// Name tag
if (label_offset < SCREEN_WIDTH)
{
	draw_set_font(objResources.font_title);
	draw_text(name_ox + label_offset, SCREEN_HEIGHT * 0.25, name);
	draw_text(zone_ox - label_offset, SCREEN_HEIGHT * 0.25 + 24, "ZONE");
	if (act > 0) draw_sprite(sprActNumber, act - 1, zone_ox - label_offset + string_width("ZONE"), SCREEN_HEIGHT * 0.25 + 24);
}
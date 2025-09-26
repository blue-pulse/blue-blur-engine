/// @description Move elements
var enter_speed = 16;
var exit_speed = 32;

switch (state)
{
	// Enter setpieces
	case 1:
	{
		// Shift blue backdrop down
		if (backdrop_offset < SCREEN_HEIGHT)
		{
			backdrop_offset = min(backdrop_offset + enter_speed, SCREEN_HEIGHT);
		}
		
		// Shift yellow band to the left
		if (band_offset > 0)
		{
			band_offset = max(band_offset - enter_speed, 0);
		}
		
		// Shift red banner to the right
		if (band_offset < 112 - fold_width)
		{
			banner_offset = min(banner_offset + enter_speed, 112);
			if (banner_offset >= 112) state = 2;
		}
		break;
	}
	
	// Enter labels
	case 2:
	{
		label_offset = max(label_offset - enter_speed, 0);
		if (label_offset <= 0)
		{
			// Display full title card for a bit
			state = 3;
			alarm[0] = 72;
		}
		break;
	}
	
	// Exit red banner to the left
	case 4:
	{
		banner_offset -= exit_speed;
		if (banner_offset <= fold_width) state = 5;
		break;
	}
	
	// Exit yellow band to the right
	case 5:
	{
		band_offset += exit_speed;
		if (band_offset >= SCREEN_WIDTH) state = 6;
		break;
	}
	
	// Exit blue backdrop up
	case 6:
	{
		backdrop_offset -= exit_speed;
		if (backdrop_offset <= 0)
		{
			// Start stage
			objStage.started = true;
			objStage.timer_enabled = true;
			
			// Display labels for a bit
			state = 7;
			alarm[0] = 72;
		}
		break;
	}
	
	// Exit labels
	case 8:
	{
		label_offset += exit_speed;
		if (label_offset >= SCREEN_WIDTH) instance_destroy();
		break;
	}
	
	// AUTHOR NOTE: states set before an alarm (3 & 7) are for display and are thus not listed.
}
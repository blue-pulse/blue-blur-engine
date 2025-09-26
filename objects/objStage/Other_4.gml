/// @description Start stage

// Set stage data and music
switch (room)
{
	case rm_test_zone:
	{
		name = "DEMONSTRATION";
		act = 1;
		audio_enqueue_bgm(bgmMadGear, 0, true);
		break;
	}
}

// Create overlays
instance_create_layer(0, 0, "Overlays", objTitleCard);
instance_create_layer(0, 0, "Overlays", objHUD);

// Caption
var captions = ["From the screen, to the ring, to the pen, to the king.",
				"Don't be shy bro, just talk tuah.",
				"Who'd win in a fight: 1 billion lions or 1 of every Pokemon?",
				"Why do they call it oven when you of in the cold food of out hot eat the food?",
				"Why has Monolith not added anything new? Is he stupid?",
				"This guy sucks at Sonic 4 Genesis.",
				"(╯°□°）╯︵ ┻━┻"];
var n = irandom(array_length(captions) - 1);
window_set_caption(captions[n]);
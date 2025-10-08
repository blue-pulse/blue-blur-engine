/// @description Reward player

// Stop rising
vspeed = 0;

with (player_id)
{
	// Abort if dead
	if (state == player_is_dead) break;
	
	// Get reward type
	switch (other.image_index)
	{
		case 0: // 10 rings
		{
			player_add_rings(10);
			break;
		}
		case 1: // Superspeed
		{
			superspeed_timer = 1200;
			player_update_physics();
			break;
		}
		case 2: // Invincibility
		{
			invincibility_timer = 1200;
			//audio_enqueue_bgm(bgmInvincibility, 1, true);
			
			// Create invincibility effect
			if (invincibility_effect == noone)
			{
				invincibility_effect = instance_create_depth(x, y, depth - 1, objInvincibility);
				invincibility_effect.player_id = id;
			}
			break;
		}
		case 8: // Life
		{
			player_add_lives(1);
			break;
		}
	}
}

// Finish
alarm[1] = 32;
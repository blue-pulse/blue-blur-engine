/// @description Patrol
if (turn_time <= 0 and shoot_time <= 0)
{
	if (hspeed != 0)
	{
		// Turn around, if applicable
		if (x < xstart - 64 or x > xstart + 64)
		{
			turn_time = 30;
			hspeed = 0;
		}
		else
		{
			// Prepare to fire at the player
			var player = instance_nearest(x, y, objPlayer);
			if (player != noone and y < player.y and can_shoot)
			{
				var x_diff = x - player.x;
				if (abs(x_diff) < 45 and sign(x_diff) != image_xscale)
				{
					shoot_time = 50;
					can_shoot = false;
					hspeed = 0;
					sprite_index = sprBuzzerShoot;
				}
			}
		}
	}
	else
	{
		// Flip if previously turning around
		if (sprite_index != sprBuzzerShoot)
		{
			image_xscale *= -1;
			can_shoot = true;
		}
		else sprite_index = sprBuzzerFly;
		
		// Start moving again
		hspeed = 1.5 * image_xscale;
	}
}
else if (turn_time > 0)
{
	--turn_time;
}
else if (shoot_time > 0 and --shoot_time == 20)
{
	// Shooting
	instance_create_layer(x - 12 * image_xscale, y + 24, layer, objBuzzerShot,
	{
		image_xscale,
		hspeed : 1.5 * image_xscale,
		vspeed : 1.5
	});
}
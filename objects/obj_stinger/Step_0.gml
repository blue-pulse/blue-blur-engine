if (turn_time <= 0 and shoot_time <= 0)
{
	if (hspeed != 0)
	{
		// Turn around, if applicable
		if (x < xstart - 64 or x > xstart + 64)
		{
			turn_time = movement_wait;
			hspeed = 0;
		}
		else
		{
			// Prepare to fire at the player
			var player = instance_nearest(x, y, Player);
			if (player != noone and y < player.y and can_shoot)
			{
				var x_diff = x - player.x;
				if (abs(x_diff) < 45 and sign(x_diff) != image_xscale)
				{
					shoot_time = movement_wait;
					can_shoot = false;
					hspeed = 0;
					sprite_index = spr_stinger_shoot;
				}
			}
		}
	}
	else
	{
		// Flip if previously turning around
		if (sprite_index != spr_stinger_shoot)
		{
			image_xscale *= -1;
			can_shoot = true;
		}
		else sprite_index = spr_stinger_fly;
		
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
	vfx_create(x + 12 * image_xscale, y + 12, obj_stinger_bullet, {
		image_xscale,
		hspeed : 1.5 * image_xscale,
		vspeed : 1.5
	});
}
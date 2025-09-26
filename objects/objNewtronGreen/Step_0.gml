/// @description Behavior
switch (state)
{
	// Waiting
	case 1:
	{
		var player = instance_nearest(x, y, objPlayer);
		if (player != noone and distance_to_object(player) < 30)
		{
			visible = true;
			image_speed = 0.075;
			image_xscale = sign(player.x - x);
			state = 2;
		}
		break;
	}
	
	// Fading in
	case 2:
	{
		if (image_index + image_speed > 2)
		{
			image_speed = 0;
			shoot_time = 60;
			state = 3;
		}
		break;
	}
	
	// Shooting
	case 3:
	{
		if (--shoot_time == 30)
		{
			image_index = 2;
			instance_create_layer(x + image_xscale * 25, y - 7, layer, objNewtronShot, { hspeed : image_xscale * 3 });
		}
		else if (shoot_time <= 0)
		{
			image_speed = -0.075;
			state = 4;
		}
		break;
	}
	
	// Fading out
	case 4:
	{
		if (image_index + image_speed < 0) instance_destroy(id, false);
		break;
	}
}
/// @description Bounce

// Abort if previously in collision
if (place_meeting(xprevious, yprevious, other.id)) exit;
var mask_rotation = gravity_angle();

// Redirect
if (x_speed != 0)
{
	x_speed *= -0.25;
	repeat (sprite_width)
	{
		if (place_meeting(x, y, other.id))
		{
			x -= dcos(mask_rotation) * sign(x_speed);
			y += dsin(mask_rotation) * sign(x_speed);
		}
		else break;
	}
}

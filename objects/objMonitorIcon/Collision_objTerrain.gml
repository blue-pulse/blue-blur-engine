/// @description Bounce

// Abort if previously in collision
if (place_meeting(xprevious, yprevious, other.id)) exit;
var mask_rotation = gravity_angle();

// Redirect
if (hor_speed != 0)
{
	hor_speed *= -0.25;
	repeat (sprite_width)
	{
		if (place_meeting(x, y, other.id))
		{
			x -= dcos(mask_rotation) * sign(hor_speed);
			y += dsin(mask_rotation) * sign(hor_speed);
		}
		else break;
	}
}

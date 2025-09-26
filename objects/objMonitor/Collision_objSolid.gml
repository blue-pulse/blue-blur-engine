/// @description Eject and land
if (vspeed > 0)
{
	while (place_meeting(x, y, other.id))
	{
		--y;
	}
	vspeed = 0;
	gravity = 0;
}
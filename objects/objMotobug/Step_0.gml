/// @description Movement and collision

// Vertical
if (place_meeting(x, y + 1, objSolid))
{
	while (place_meeting(x, y, objSolid))
	{
		--y;
	}
}
else ++y;

// Horizontal
if (place_meeting(x + hspeed, y - 1, objSolid))
{
	// Move outside of wall
	while (place_meeting(x, y, objSolid)) x -= hspeed;
	
	// Initialize turnaround
	if (image_xscale == hspeed)
	{
		hspeed = 0;
		alarm[0] = 60;
		image_speed = 0;
	}
}
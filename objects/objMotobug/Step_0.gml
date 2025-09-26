/// @description Movement and collision

// Vertical
if (place_meeting(x, y + 1, obj_solid))
{
	while (place_meeting(x, y, obj_solid))
	{
		--y;
	}
}
else ++y;

// Horizontal
if (place_meeting(x + hspeed, y - 1, obj_solid))
{
	// Move outside of wall
	while (place_meeting(x, y, obj_solid)) x -= hspeed;
	
	// Initialize turnaround
	if (image_xscale == hspeed)
	{
		hspeed = 0;
		alarm[0] = 60;
		image_speed = 0;
	}
}
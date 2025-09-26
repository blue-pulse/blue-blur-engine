/// @description Eject
if (vspeed == 0) exit;
while (place_meeting(x, y, other)) y--;

// Stop falling
vspeed = 0;
gravity = 0;

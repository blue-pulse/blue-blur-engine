/// @description Movement
if (not moving) exit;

if (objScreen.image_index mod 128 < 64)
{
	if (offset < sprite_height) offset += sprite_height * 0.25;
}
else if (offset > 0)
{
	offset -= sprite_height * 0.25;
}

// Apply offset
x = xstart + dsin(image_angle) * offset;
y = ystart + dcos(image_angle) * offset;
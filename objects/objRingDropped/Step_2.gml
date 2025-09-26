/// @description Destroy off-screen / Animate
if (not in_view(id, CAMERA_PADDING))
{
	instance_destroy();
	exit;
}

// Slow down animation
image_speed -= 0.002;

// Blinking
if (alarm[0] < 64) visible = not visible;
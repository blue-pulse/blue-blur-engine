/// @description Set new animation
if (abs(x_speed) < 6)
{
	animation_index = "walk";
}
else if (abs(x_speed) < 10)
{
	animation_index = "run";
}
else animation_index = "sprint";
timeline_speed = 1 / max(8 - abs(x_speed), 1);

/// @description Set new animation
if (abs(hor_speed) < 6)
{
	animation_index = "walk";
}
else if (abs(hor_speed) < 10)
{
	animation_index = "run";
}
else animation_index = "sprint";
timeline_speed = 1 / max(8 - abs(hor_speed), 1);

/// @description Update animation
switch (image_index)
{
	case 0:
	{
		++image_index;
		alarm[0] = 2;
		break;
	}
	case 1:
	{
		++image_index;
		alarm[0] = 6;
		break;
	}
	case 2:
	{
		--image_index;
		break;
	}
}
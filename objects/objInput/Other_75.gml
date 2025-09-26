/// @description Detect gamepads
switch (async_load[? "event_type"])
{
	case "gamepad discovered":
	{
		if (gp_device == -1)
		{
			gp_device = async_load[? "pad_index"];
			
			// Assign buttons to events
			buttons =
			{
				up : gp_padu,
				down : gp_padd,
				left : gp_padl,
				right : gp_padr,
				a : gp_face1,
				b : gp_face2,
				c : gp_face3,
				start : gp_start,
				resize : gp_select
			};
		}
		break;
	}
	case "gamepad lost":
	{
		if (gp_device == async_load[? "pad_index"])
		{
			gp_device = -1;
		}
		break;
	}
}
function tile_ignore_v(index,toPositive)
{
	/* Returns TRUE if the tile should be ignored, else returns FALSE */
	
	// Check for LBR Tiles
	if index > global.tile_data[1] * 2
	{
		if object_index == Player
		{
			if !Player.is_grounded or !Player.collision_mode[0]
			{
				return toPositive;
			}
			else
			{
				return true;
			}
		}
		else
		{
			return toPositive;
		}
	}
	
	// Check for Top Solid Tiles
	else if index > global.tile_data[1]
	{
		if object_index == Player
		{
			if !Player.is_grounded
			{
				return !toPositive;
			}
			else switch Player.collision_mode[0]
			{
				case 0:
					return !toPositive;
				break;
				case 1:
					return true;
				break;
				case 2:
					return toPositive;
				break;
				case 3:
					return true;
				break;
			}
		}
		else
		{
			return !toPositive;
		}
	}
	
	// Do not ignore Full Solid Tiles
	else
	{
		return false;
	}
}
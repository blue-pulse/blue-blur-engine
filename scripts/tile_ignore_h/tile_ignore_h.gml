/// @function tile_ignore_h(index,toPositive)
function tile_ignore_h(index,toPositive)
{
	/* Returns TRUE if the tile should be ignored, else returns FALSE */
	
	// Check for LBR Tiles
	if index > global.tile_data[1] * 2
	{
		if object_index == Player
		{
			if !Player.is_grounded or !Player.collision_mode[0]
			{
				return false;
			}
			else
			{
				return true;
			}
		}
		else
		{
			return false;
		}
	}
	
	// Check for Top Solid Tiles
	else if index > global.tile_data[1]
	{
		if object_index == Player
		{
			if !Player.is_grounded
			{
				return true;
			}
			else switch Player.collision_mode[0]
			{
				case 0:
					return true;
				break;
				case 1:
					return !toPositive;
				break;
				case 2:
					return true;
				break;
				case 3:
					return toPositive;
				break;
			}
		}
		else
		{
			return true;
		}
	}
	
	// Do not ignore Full Solid Tiles
	else
	{
		return false;
	}
}
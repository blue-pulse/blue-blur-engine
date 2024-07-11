function tile_check(x,y,noTopSolid,tilelayer)
{
	x = floor(x);
	y = floor(y);
	
	// Exit if no tiledata found
	if !array_length(global.tile_data)
	{
		return false;
	}
    if x <= 0 or y <= 0 or x >= room_width or y >= room_height 
    {
        return false;
    }
	
	// Get tile at position
	var plane	  = global.tile_layers[tilelayer];
    var Tile      = tilemap_get(plane, x div 16, y div 16);
    var TileIndex = tile_get_index(Tile);
	
   	// Exit if tile is top-only and we're ignoring them
    if noTopSolid and TileIndex > global.tile_data[1]
    {
        return false;
    }
	
	// Return check result
	if tile_get_flip(Tile)
	{
		return y mod 16 < tile_get_height(x, Tile, TileIndex);
	}
	else
	{
		return 16 - 1 - y mod 16 < tile_get_height(x, Tile, TileIndex);
	}
}
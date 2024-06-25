function tile_set_data(name,tileAmount,layerA,layerB)
{
	if name != noone
	{
		global.TileData   = [name, tileAmount];
		global.TileLayers = [layer_tilemap_get_id(layerA), layer_tilemap_get_id(layerB), layerA, layerB];
	}
	else
	{
		global.TileData   = [];
		global.TileLayers = [];
	}
}
function tile_set_data(name,tileAmount,layerA,layerB)
{
	if name != noone
	{
		global.tile_data   = [name, tileAmount];
		global.tile_layers = [layer_tilemap_get_id(layerA), layer_tilemap_get_id(layerB), layerA, layerB];
	}
	else
	{
		global.tile_data   = [];
		global.tile_layers = [];
	}
}
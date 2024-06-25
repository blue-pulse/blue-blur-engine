function tile_load_data(){
		// Clear tiledata
		global.tile_angles   = [];
		global.tile_widths  = [];
		global.tile_heights = [];
	

			var AngleMap  = "anglemap"  + global.tile_data[0] + ".bin";
			var HeightMap = "heightmap" + global.tile_data[0] + ".bin";
			var WidthMap  = "widthmap"  + global.tile_data[0] + ".bin";
	
			// Load data files
			for (var k = 0; k < 3; k++)
			{
				switch k
				{
					case 0:
						var Name = AngleMap;
					break;
					case 1:
						var Name = HeightMap;
					break;
					case 2:
						var Name = WidthMap;
					break;
				}
		
				// Load data file
				var File = file_bin_open("config/tiledata/" + Name, 0);	
				var Size = file_bin_size(File);
				if  File 
				{
					for (var i = 0; i <= global.tile_data[1]; i++) 
					{
						switch Name 
						{
							// Load anglemap
							case AngleMap:
							{	
								global.tile_angles[i] = i < Size ? (256 - file_bin_read_byte(File)) * 360 / 256 : 0;
							}
							break;
					
							// Load heightmap
							case HeightMap:
							{
								for (var j = 0; j < 16; j++) 
								{
									global.tile_heights[i][j] = (i * 16 < Size) ? file_bin_read_byte(File) : 0;
								}
							}
							break;
					
							// Load widthmap
							case WidthMap:  
							{
								for (var j = 0; j < 16; j++) 
								{
									global.tile_widths[i][j] = (i * 16 < Size) ? file_bin_read_byte(File) : 0;	 
								}
							}
							break;
						}
					}
					file_bin_close(File);									 
				}
			}
}

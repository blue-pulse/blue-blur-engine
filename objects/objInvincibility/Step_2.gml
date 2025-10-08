/// @description Movement

// Snap to player
x = player_id.x div 1;
y = player_id.y div 1;

// Position circles
for (var n = array_length(circle_ox) - 1; n > -1; --n)
{
	var offset = player_id.table_size - 1 - (n + 1) * 3;
	circle_ox[n] = player_id.pos_grid[0, offset] div 1;
	circle_oy[n] = player_id.pos_grid[1, offset] div 1;
}

// Rotate circles
inner_angle -= 11.25;
outer_angle -= 22.5;
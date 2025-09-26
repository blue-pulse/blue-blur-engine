/// @description Draw stars

// Get rotation properties
var radius = 16;
var sine = dsin(inner_angle) * radius;
var cosine = dcos(inner_angle) * radius;

// First circle
var frame = image_index mod array_length(frame_table1);
if (image_index mod 2 != 0)
{
	draw_sprite(sprInvincibilityStar, frame_table1[frame], x + cosine, y - sine);
	draw_sprite(sprInvincibilityStar, frame_table1[frame] + 5, x - cosine, y + sine);
}
else
{
	draw_sprite(sprInvincibilityStar, frame_table1[frame], x + sine, y + cosine);
	draw_sprite(sprInvincibilityStar, frame_table1[frame] + 5, x - sine, y - cosine);
}

sine = dsin(outer_angle) * radius;
cosine = dcos(outer_angle) * radius;

// Second circle
frame = image_index mod array_length(frame_table2);
draw_sprite(sprInvincibilityStar, frame_table2[frame], circle_ox[0] + cosine, circle_oy[0] - sine);
draw_sprite(sprInvincibilityStar, frame_table2[frame] + 7, circle_ox[0] - cosine, circle_oy[0] + sine);

// Third circle
frame = image_index mod array_length(frame_table3);
draw_sprite(sprInvincibilityStar, frame_table3[frame], circle_ox[1] - sine, circle_oy[1] - cosine);
draw_sprite(sprInvincibilityStar, frame_table3[frame] + 6, circle_ox[1] + sine, circle_oy[1] + cosine);

// Fourth circle
frame = image_index mod array_length(frame_table4);
draw_sprite(sprInvincibilityStar, frame_table4[frame], circle_ox[2] + cosine, circle_oy[2] - sine);
draw_sprite(sprInvincibilityStar, frame_table4[frame] + 5, circle_ox[2] - cosine, circle_oy[2] + sine);
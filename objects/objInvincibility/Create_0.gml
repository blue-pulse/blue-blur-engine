/// @description Initialize
player_id = noone;

// Position
circle_ox = array_create(3, xstart);
circle_oy = array_create(3, ystart);

// Rotation
inner_angle = 0;
outer_angle = 0;

// Animation frames
frame_table1 = [5, 5, 6, 6, 7, 7, 6, 6, 5, 5];
frame_table2 = [2, 3, 4, 5, 6, 7, 6, 5, 4, 3, 2];
frame_table3 = [1, 2, 3, 4, 5, 6, 7, 6, 5, 4, 3, 2, 1];
frame_table4 = [0, 1, 2, 3, 4, 5, 4, 3, 2, 1, 0];

/* AUTHOR NOTE:
> The idea for rendering the invincibility stars as seen above was taken from the Orbinaut Framework.
> See SonicForGMS' invincibility star timelines for reference on counting and displayed frames. */
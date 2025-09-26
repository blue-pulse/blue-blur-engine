/// @description Initialize
event_inherited();
collision_layer = -1; // No collision happens with the player on layer mismatch
surface_angle = -1; // Measured in degrees; set this to > -1 to hard-code this solid's angle, otherwise it will be calculated based on its shape
shape = SHP_RECTANGLE; // SHP_RECTANGLE, SHP_RIGHT_TRIANGLE, SHP_QUARTER_PIPE, SHP_QUARTER_ELLIPSE or SHP_CUSTOM; ignored if surface angle > -1, except if SHP_CUSTOM is assigned
semisolid = false; // Only the bottom half of the player's mask can collide, and only if their top half isn't also colliding
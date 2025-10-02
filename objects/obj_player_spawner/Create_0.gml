// Create player
instance_create_layer(x, y, "General", global.character);
//instance_create_depth(x, y, 0, Camera);
//Camera.target = global.character;

// Destroy spawner
instance_destroy();

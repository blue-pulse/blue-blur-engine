// Variables
var room_manager = (room == rm_title) ? (obj_title_manager) : (obj_home_manager);

// Create controllers
manager_create(obj_stage_manager);
manager_create(room_manager);

// Destroy spawner
instance_destroy();

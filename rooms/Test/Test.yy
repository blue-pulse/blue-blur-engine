{
  "$GMRoom":"",
  "%Name":"Test",
  "creationCodeFile":"rooms/Test/RoomCreationCode.gml",
  "inheritCode":false,
  "inheritCreationOrder":false,
  "inheritLayers":false,
  "instanceCreationOrder":[
    {"name":"inst_4F319832","path":"rooms/Test/Test.yy",},
    {"name":"inst_13FA6CEA","path":"rooms/Test/Test.yy",},
  ],
  "isDnd":false,
  "layers":[
    {"$GMRLayer":"","%Name":"setup","depth":0,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[
        {"$GMRInstanceLayer":"","%Name":"controllers","depth":100,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"instances":[
            {"$GMRInstance":"","%Name":"inst_13FA6CEA","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"name":"inst_13FA6CEA","objectId":{"name":"obj_game_controller","path":"objects/obj_game_controller/obj_game_controller.yy",},"properties":[],"resourceType":"GMRInstance","resourceVersion":"2.0","rotation":0.0,"scaleX":1.0,"scaleY":1.0,"x":0.0,"y":0.0,},
          ],"layers":[],"name":"controllers","properties":[],"resourceType":"GMRInstanceLayer","resourceVersion":"2.0","userdefinedDepth":false,"visible":true,},
      ],"name":"setup","properties":[],"resourceType":"GMRLayer","resourceVersion":"2.0","userdefinedDepth":false,"visible":true,},
    {"$GMRLayer":"","%Name":"collision","depth":200,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[
        {"$GMRTileLayer":"","%Name":"collision_layer_a","depth":300,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"name":"collision_layer_a","properties":[],"resourceType":"GMRTileLayer","resourceVersion":"2.0","tiles":{"SerialiseHeight":14,"SerialiseWidth":25,"TileCompressedData":[
              -26,256,-5,0,-13,-2147483648,9,1879048305,1879048304,1879048303,1879048193,1879048193,1,256,0,0,-19,
              -2147483648,5,1879048301,1879048299,1,256,0,-21,-2147483648,5,1879048300,1,256,0,0,-21,-2147483648,4,
              1,256,-2147483648,0,-21,-2147483648,5,1,256,-2147483648,-2147483648,0,-15,-2147483648,1,0,-4,-2147483648,
              2,1,256,-18,-2147483648,-2,0,-3,-2147483648,2,1,256,-23,0,2,1,256,-23,0,2,1,256,-22,0,3,1610612844,1,
              256,-21,0,4,1610612845,1610612843,1,256,-18,0,6,1610612849,1610612848,1610612847,1610612737,1610612737,
              1,-25,256,
            ],"TileDataFormat":1,},"tilesetId":{"name":"ts_terrain_collision","path":"tilesets/ts_terrain_collision/ts_terrain_collision.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
        {"$GMRTileLayer":"","%Name":"collision_layer_b","depth":400,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"name":"collision_layer_b","properties":[],"resourceType":"GMRTileLayer","resourceVersion":"2.0","tiles":{"SerialiseHeight":14,"SerialiseWidth":25,"TileCompressedData":[-207,-2147483648,-143,0,],"TileDataFormat":1,},"tilesetId":{"name":"ts_terrain_collision","path":"tilesets/ts_terrain_collision/ts_terrain_collision.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
      ],"name":"collision","properties":[],"resourceType":"GMRLayer","resourceVersion":"2.0","userdefinedDepth":false,"visible":true,},
    {"$GMRLayer":"","%Name":"instances","depth":500,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[
        {"$GMRInstanceLayer":"","%Name":"player","depth":600,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"instances":[
            {"$GMRInstance":"","%Name":"inst_4F319832","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"name":"inst_4F319832","objectId":{"name":"obj_player","path":"objects/obj_player/obj_player.yy",},"properties":[],"resourceType":"GMRInstance","resourceVersion":"2.0","rotation":0.0,"scaleX":1.0,"scaleY":1.0,"x":192.0,"y":32.0,},
          ],"layers":[],"name":"player","properties":[],"resourceType":"GMRInstanceLayer","resourceVersion":"2.0","userdefinedDepth":false,"visible":true,},
      ],"name":"instances","properties":[],"resourceType":"GMRLayer","resourceVersion":"2.0","userdefinedDepth":false,"visible":true,},
    {"$GMRLayer":"","%Name":"decorations","depth":700,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[
        {"$GMRBackgroundLayer":"","%Name":"background","animationFPS":15.0,"animationSpeedType":0,"colour":4283190348,"depth":800,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"hspeed":0.0,"htiled":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"name":"background","properties":[],"resourceType":"GMRBackgroundLayer","resourceVersion":"2.0","spriteId":null,"stretch":false,"userdefinedAnimFPS":false,"userdefinedDepth":false,"visible":true,"vspeed":0.0,"vtiled":false,"x":0,"y":0,},
      ],"name":"decorations","properties":[],"resourceType":"GMRLayer","resourceVersion":"2.0","userdefinedDepth":false,"visible":true,},
  ],
  "name":"Test",
  "parent":{
    "name":"Rooms",
    "path":"folders/Stages/Rooms.yy",
  },
  "parentRoom":null,
  "physicsSettings":{
    "inheritPhysicsSettings":false,
    "PhysicsWorld":false,
    "PhysicsWorldGravityX":0.0,
    "PhysicsWorldGravityY":10.0,
    "PhysicsWorldPixToMetres":0.1,
  },
  "resourceType":"GMRoom",
  "resourceVersion":"2.0",
  "roomSettings":{
    "Height":224,
    "inheritRoomSettings":false,
    "persistent":false,
    "Width":400,
  },
  "sequenceId":null,
  "views":[
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
  ],
  "viewSettings":{
    "clearDisplayBuffer":true,
    "clearViewBackground":false,
    "enableViews":false,
    "inheritViewSettings":false,
  },
  "volume":1.0,
}
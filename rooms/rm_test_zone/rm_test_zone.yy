{
  "$GMRoom":"v1",
  "%Name":"rm_test_zone",
  "creationCodeFile":"rooms/rm_test_zone/RoomCreationCode.gml",
  "inheritCode":false,
  "inheritCreationOrder":false,
  "inheritLayers":false,
  "instanceCreationOrder":[
    {"name":"inst_4F319832","path":"rooms/rm_test_zone/rm_test_zone.yy",},
    {"name":"inst_13FA6CEA","path":"rooms/rm_test_zone/rm_test_zone.yy",},
  ],
  "isDnd":false,
  "layers":[
    {"$GMRLayer":"","%Name":"setup","depth":0,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[
        {"$GMRInstanceLayer":"","%Name":"controllers","depth":100,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"instances":[
            {"$GMRInstance":"v1","%Name":"inst_13FA6CEA","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"name":"inst_13FA6CEA","objectId":{"name":"obj_core_controller","path":"objects/obj_core_controller/obj_core_controller.yy",},"properties":[],"resourceType":"GMRInstance","resourceVersion":"2.0","rotation":0.0,"scaleX":1.0,"scaleY":1.0,"x":0.0,"y":0.0,},
          ],"layers":[],"name":"controllers","properties":[],"resourceType":"GMRInstanceLayer","resourceVersion":"2.0","userdefinedDepth":false,"visible":true,},
      ],"name":"setup","properties":[],"resourceType":"GMRLayer","resourceVersion":"2.0","userdefinedDepth":false,"visible":true,},
    {"$GMRLayer":"","%Name":"collision","depth":200,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[
        {"$GMRTileLayer":"","%Name":"collision_layer_a","depth":300,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"name":"collision_layer_a","properties":[],"resourceType":"GMRTileLayer","resourceVersion":"2.0","tiles":{"SerialiseHeight":14,"SerialiseWidth":62,"TileCompressedData":[
              1,1,-6,0,-56,1,-5,0,-2,-2147483648,-8,0,-3,-2147483648,-6,0,-20,-2147483648,-6,0,-4,-2147483648,10,536870951,
              536870952,536870953,536870954,536870913,536870913,1,1,0,0,-19,-2147483648,-3,0,-33,-2147483648,6,536870955,
              536870956,536870913,1,1,0,-20,-2147483648,-3,0,-34,-2147483648,6,536870957,536870958,1,1,0,0,-21,-2147483648,
              1,0,-35,-2147483648,5,536870959,1,1,0,0,-21,-2147483648,1,0,-35,-2147483648,6,536870960,1,1,0,-2147483648,
              0,-15,-2147483648,1,0,-4,-2147483648,1,0,-35,-2147483648,4,536870961,1,268435457,268435505,-5,0,-11,
              256,-7,0,-11,256,-7,-2147483648,-11,256,-6,-2147483648,4,49,268435457,268435457,268435504,-23,0,-35,
              -2147483648,4,48,268435457,268435457,268435503,-23,0,-35,-2147483648,5,47,268435457,268435457,268435502,
              268435501,-22,0,-34,-2147483648,2,45,46,-3,268435457,2,268435500,268435499,-21,0,-33,-2147483648,3,43,
              44,1,-4,268435457,4,268435498,268435497,268435496,268435495,-42,0,-6,-2147483648,7,39,40,41,42,1,1,268435457,
              -62,256,
            ],"TileDataFormat":1,},"tilesetId":{"name":"ts_terrain_collision","path":"tilesets/ts_terrain_collision/ts_terrain_collision.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
        {"$GMRTileLayer":"","%Name":"collision_layer_b","depth":400,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"name":"collision_layer_b","properties":[],"resourceType":"GMRTileLayer","resourceVersion":"2.0","tiles":{"SerialiseHeight":14,"SerialiseWidth":62,"TileCompressedData":[
              -503,-2147483648,-18,0,-37,-2147483648,-25,0,-37,-2147483648,-25,0,-37,-2147483648,-25,0,-37,-2147483648,
              -25,0,-37,-2147483648,-25,0,-37,-2147483648,
            ],"TileDataFormat":1,},"tilesetId":{"name":"ts_terrain_collision","path":"tilesets/ts_terrain_collision/ts_terrain_collision.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
      ],"name":"collision","properties":[],"resourceType":"GMRLayer","resourceVersion":"2.0","userdefinedDepth":false,"visible":true,},
    {"$GMRLayer":"","%Name":"instances","depth":500,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[
        {"$GMRInstanceLayer":"","%Name":"player","depth":600,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"instances":[
            {"$GMRInstance":"v1","%Name":"inst_4F319832","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"name":"inst_4F319832","objectId":{"name":"obj_player","path":"objects/obj_player/obj_player.yy",},"properties":[],"resourceType":"GMRInstance","resourceVersion":"2.0","rotation":0.0,"scaleX":1.0,"scaleY":1.0,"x":224.0,"y":64.0,},
          ],"layers":[],"name":"player","properties":[],"resourceType":"GMRInstanceLayer","resourceVersion":"2.0","userdefinedDepth":false,"visible":true,},
      ],"name":"instances","properties":[],"resourceType":"GMRLayer","resourceVersion":"2.0","userdefinedDepth":false,"visible":true,},
    {"$GMRLayer":"","%Name":"decorations","depth":700,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[
        {"$GMRBackgroundLayer":"","%Name":"background","animationFPS":15.0,"animationSpeedType":0,"colour":4283190348,"depth":800,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"hspeed":0.0,"htiled":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"name":"background","properties":[],"resourceType":"GMRBackgroundLayer","resourceVersion":"2.0","spriteId":null,"stretch":false,"userdefinedAnimFPS":false,"userdefinedDepth":false,"visible":true,"vspeed":0.0,"vtiled":false,"x":0,"y":0,},
      ],"name":"decorations","properties":[],"resourceType":"GMRLayer","resourceVersion":"2.0","userdefinedDepth":false,"visible":true,},
  ],
  "name":"rm_test_zone",
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
    "Width":990,
  },
  "sequenceId":null,
  "views":[
    {"hborder":400,"hport":768,"hspeed":-1,"hview":224,"inherit":false,"objectId":{"name":"obj_player","path":"objects/obj_player/obj_player.yy",},"vborder":224,"visible":true,"vspeed":-1,"wport":1366,"wview":400,"xport":0,"xview":0,"yport":0,"yview":0,},
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
    "enableViews":true,
    "inheritViewSettings":false,
  },
  "volume":1.0,
}
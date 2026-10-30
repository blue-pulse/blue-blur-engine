// Game parameters
#macro TITLE "Blue Blur Engine"
#macro UNICODE "abcdefghijklmnopqrstuvwxyz1234567890:."
#macro WIDTH 500
#macro HEIGHT 280
#macro SCALE 2
#macro MAX_FPS 60
#macro MAX_SOUNDS 200
#macro TIMEZONE timezone_utc

// File manager
#macro SIGNER "BlueBlurEngine"
#macro MAX_SLOTS 10
#macro XOR_KEY 3179411283192014336
#macro FILE_EXT ".dat"
#macro ENCRYPT true

// Packages
#macro RAW mixer_modes.overlap
#macro SKIP mixer_modes.single
#macro REPLACE mixer_modes.swap
#macro SETTINGS "settings.dat"
#macro USERDATA "userdata.dat"
#macro SAVEDATA "savedata.dat"

// Animation
#macro ANIMATION_DEFAULT_SPEED 1
#macro ANIMATION_USE_TRANSITIONS true

// States phases
#macro INIT -1
#macro STEP 0
#macro STOP 1

// Misc
#macro DIR_BOTTOM 2
#macro DIR_LEFT -1
#macro DIR_RIGHT 1
#macro DIR_TOP -2
#macro MS_PER_SECOND 1000
#macro ROOM_BOTTOM room_height
#macro ROOM_LEFT 0
#macro ROOM_RIGHT room_width
#macro ROOM_TOP 0

// Shortcuts
#macro async_queue global.async_operations
#macro font_black global.font_hud_black
#macro font_blue global.font_hud_blue
#macro font_debug global.font_hud_debug
#macro font_golden global.font_hud_golden
#macro font_gray global.font_hud_gray
#macro font_silver global.font_hud_silver
#macro is_paused global.game_is_paused
#macro is_fullscreen window_get_fullscreen()
#macro sys_active global.game_state == states.active
#macro ticks global.framecount

// Replay
#macro REPLAY_SCENARIO ""

// Aliases
#macro Camera obj_camera
#macro Particles global.particles
#macro Player obj_player
#macro Protagonist global.protagonist
#macro Reticle obj_reticle
#macro Stage obj_stage_manager
#macro View view_get_camera(0)

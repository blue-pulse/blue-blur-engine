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
#macro RAW ESAU_MODES.OVERLAP
#macro SKIP ESAU_MODES.SINGLE
#macro REPLACE ESAU_MODES.SWAP
#macro SETTINGS "settings.dat"
#macro USERDATA "userdata.dat"
#macro SAVEDATA "savedata.dat"

// States phases
#macro INIT -1
#macro STEP 0
#macro STOP 1

// Misc
#macro DIR_BOTTOM 2
#macro DIR_LEFT -1
#macro DIR_RIGHT 1
#macro DIR_TOP -2
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

// Inputs
#macro vb_keyboard 0
#macro vb_gamepad 1
#macro vb_touch 2
#macro vb_generic 3
#macro vb_up INPUT_VERB.UP
#macro vb_down INPUT_VERB.DOWN
#macro vb_left INPUT_VERB.LEFT
#macro vb_right INPUT_VERB.RIGHT
#macro vb_start INPUT_VERB.START
#macro vb_select INPUT_VERB.SELECT
#macro vb_accept INPUT_VERB.ACCEPT
#macro vb_back INPUT_VERB.BACK
#macro vb_a INPUT_VERB.A
#macro vb_b INPUT_VERB.B
#macro vb_x INPUT_VERB.X
#macro vb_y INPUT_VERB.Y

// Aliases
#macro Camera obj_camera
#macro Particles global.particles
#macro Player obj_player
#macro Protagonist global.protagonist
#macro Reticle obj_reticle
#macro Stage obj_stage_manager
#macro View view_get_camera(0)

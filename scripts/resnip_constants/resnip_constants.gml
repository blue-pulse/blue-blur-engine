// Library data
#macro RESNIP_VERSION "0.2.0"
#macro RESNIP_DATE "2026-10-19"

// Direction of playback
#macro RESNIP_FORWARD 1
#macro RESNIP_BACKWARD -1

// What a snip does when it passes its last frame
enum RESNIP_END {
	HOLD,
	REWIND,
	FASTFORWARD,
	REPEAT,
	PINGPONG,
}

// When a pingpong snip counts as complete
enum RESNIP_COMPLETE {
	EDGE,
	HEAD,
	TAIL,
}

// Where resnip_stop leaves the playback
enum RESNIP_STOP {
	HERE,
	HEAD,
	TAIL,
}

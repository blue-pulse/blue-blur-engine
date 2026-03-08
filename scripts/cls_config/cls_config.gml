function cls_config() : SSave("config", SSAVE_PROTECTION.NONE) constructor {
	add_value("last", SSAVE_TYPE.REAL, 1);
	add_value("graphics", SSAVE_TYPE.STRUCT, { fullscreen: false });
	add_value("sound", SSAVE_TYPE.STRUCT, { master: 1, bgm: 1, sfx: 1, voices: 1 });
}

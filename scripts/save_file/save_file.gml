function save_file() : SSave("_slot", SSAVE_PROTECTION.ENCRYPT) constructor {
	add_value("datetime", SSAVE_TYPE.REAL, 0);
	add_value("character", SSAVE_TYPE.REAL, 5);
	add_value("lives", SSAVE_TYPE.REAL, 3);
	add_value("position", SSAVE_TYPE.ARRAY, [0, 0]);
}

global.data = {
    "settings": {
        "audio": {
            "music": 1,
            "sfx": 1,
        },
	}
};

// Crear base de datos
global.db = db_create();

// Valores por defecto
db_write(global.db, 3, "player", "lives");
db_write(global.db, 0, "player", "coins");
db_write(global.db, 1, "player", "level");

var a = db_read(global.db, 3, "player", "lives");
show_debug_message("Vidas: " + string(a));

var buffer = db_buffer_create(global.db);
buffer_compress(buffer, buffer_compress_zlib);
buffer_save(buffer, "save.sav");

/// Save Function
var buffer = db_buffer_create(global.db);
var _buffer = db_buffer_create(global.db);

    SparkleSave("save.sav", _buffer, function(_status, _buffer)
    {
        buffer_delete(_buffer);

        if (_status)
        {
            show_debug_message("Guardado OK");
        }
    });
SparkleLoad("save.sav", function(_status, _buffer)
    {
        if (_status)
        {
            global.db = db_buffer_read(_buffer);
            show_debug_message("Juego cargado!");
        }

        buffer_delete(_buffer);
    });
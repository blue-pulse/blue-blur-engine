function random_string(text, length) {
    var out = "";
    var len = string_length(text);
    if (len > 0) {
        repeat (length) {
            out += string_char_at(text, floor(random(len)) + 1);
        }
    } else {
        repeat (length) {
            out += chr(floor(random(95)) + 32);
        }
    }
    return out;
}

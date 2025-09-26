function array_duplicate(array) {
    var new_array = [];
    array_copy(new_array, 0, array, 0, array_length(array));
    return new_array;
}

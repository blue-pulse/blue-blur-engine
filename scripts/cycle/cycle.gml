function cycle(value, min_val, max_val) {
    var delta = max_val - min_val;
    return min_val + ((value - min_val + delta) mod delta);
}

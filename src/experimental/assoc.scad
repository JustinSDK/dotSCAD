use <experimental/_impl/_assoc_impl.scad>;

// treat an associative array as a dictionary.

function assoc(array, cmd, key, value) =
    is_undef(array) ? [] :
    cmd == "put" ? _assoc_put(array, key, value) :
    cmd == "get" ? _assoc_get(array, key) :
    cmd == "remove" ? _assoc_remove(array, key) : assert("Uknown command");
use <../../__comm__/_str_hash.scad>;
use <_impl/_hashmap_put_impl.scad>;

function hashmap_put(map, key, value, eq = function(e1, e2) e1 == e2, hash = function(e) _str_hash(e)) =
    _hashmap_put(map, key, value, eq, hash);
use <__comm__/_str_hash.scad>;
use <_impl/_hashset_add_impl.scad>;

function hashset_add(set, elem, eq = function(e1, e2) e1 == e2, hash = function(e) _str_hash(e)) =
    _hashset_add(set, elem, eq, hash);
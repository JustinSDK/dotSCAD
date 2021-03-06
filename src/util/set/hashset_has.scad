use <../../__comm__/_str_hash.scad>;
use <../some.scad>;

function hashset_has(set, elem, eq = function(e1, e2) e1 == e2, hash = function(e) _str_hash(e)) =
    some(set[hash(elem) % len(set)], function(e) eq(e, elem));
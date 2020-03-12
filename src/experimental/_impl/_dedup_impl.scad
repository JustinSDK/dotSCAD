use <experimental/has.scad>;

function _dedup(src, dest, leng, i = 0) = 
    i == leng ? dest :
    has(dest, src[i]) ? _dedup(src, dest, leng, i + 1) : _dedup(src, concat(dest, [src[i]]), leng, i + 1);

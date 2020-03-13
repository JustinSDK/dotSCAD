use <util/has.scad>;

function _dedup_sorted(lt, leng) =
    leng == 0 ? lt : 
    concat(
        [lt[0]],
        [for(i = [1:leng - 1]) if(lt[i] != lt[i - 1]) lt[i]]
    );

function _dedup(src, dest, leng, i = 0) = 
    i == leng ? dest :
    has(dest, src[i]) ? _dedup(src, dest, leng, i + 1) : 
                        _dedup(src, concat(dest, [src[i]]), leng, i + 1);
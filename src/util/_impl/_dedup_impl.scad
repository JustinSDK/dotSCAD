use <../some.scad> ;

function _dedup_sorted(lt, leng, eq) =
    leng == 0 ? lt : 
        is_function(eq) ?      
            concat(
                [lt[0]],
                [for(i = [1:leng - 1]) if(!eq(lt[i], lt[i - 1])) lt[i]]
            ) :
            concat(
                [lt[0]],
                [for(i = [1:leng - 1]) if(lt[i] != lt[i - 1]) lt[i]]
            );  

function _dedup_vt(src, dest, leng, i = 0) = 
    i == leng ? dest :
    // src[i] in dest ?
    search([src[i]], dest) != [[]] ? _dedup_vt(src, dest, leng, i + 1) : 
                                     _dedup_vt(src, concat(dest, [src[i]]), leng, i + 1);

function _dedup_eq(src, dest, eq, leng, i = 0) = 
    i == leng ? dest :
    some(dest, function(el) eq(el, src[i])) ? _dedup_eq(src, dest, eq, leng, i + 1) : 
                                                 _dedup_eq(src, concat(dest, [src[i]]), eq, leng, i + 1);

function _dedup(src, dest, leng, eq) = 
    is_function(eq) ? _dedup_eq(src, dest, eq, leng) : _dedup_vt(src, dest, leng);
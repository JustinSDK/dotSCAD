use <../sub_str.scad>

function _split_t_by(idxs, t) =
    let(leng = len(idxs))
    [sub_str(t, 0, idxs[0]), each [for(i = 0; i < leng; i = i + 1) sub_str(t, idxs[i] + 1, idxs[i + 1])]];
             
function _split_str_impl(t, delimiter) = 
    len(search(delimiter, t)) == 0 ? 
        [t] : _split_t_by(search(delimiter, t, 0)[0], t);  
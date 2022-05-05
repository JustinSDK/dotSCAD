function _to_3_elems_translation_vect(v) =
     let(leng = len(v))
     leng == 3 ? v : 
     leng == 2 ? [each v, 0] : [v.x, 0, 0];

function _to_translation_vect(v) = is_num(v) ? [v, 0, 0] : _to_3_elems_translation_vect(v);

FINAL_ROW = [0, 0, 0, 1];
function _m_translation_impl(v) = 
    let(vt = _to_translation_vect(v))
    [ 
        [1, 0, 0, vt.x],
        [0, 1, 0, vt.y],
        [0, 0, 1, vt.z],
        FINAL_ROW
    ];
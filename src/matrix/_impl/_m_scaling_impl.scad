function __m_scaling_to_3_elems_scaling_vect(s) =
     let(leng = len(s))
     leng == 3 ? s : 
     leng == 2 ? [each s, 1] : [s.x, 1, 1];

function __m_scaling_to_scaling_vect(s) = is_num(s) ? [s, s, s] : __m_scaling_to_3_elems_scaling_vect(s);

FINAL_ROW = [0, 0, 0, 1];
function _m_scaling_impl(s) = 
    let(v = __m_scaling_to_scaling_vect(s))
    [
        [v.x, 0, 0, 0],
        [0, v.y, 0, 0],
        [0, 0, v.z, 0],
        FINAL_ROW
    ];
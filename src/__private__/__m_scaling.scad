function __m_scaling_to_3_elems_scaling_vect(s) =
     let(leng = len(s))
     leng == 3 ? s : (
         leng == 2 ? [s[0], s[1], 1] : [s[0], 1, 1]
     );

function _to_scaling_vect(s) = is_num(s) ? [s, s, s] : __m_scaling_to_3_elems_scaling_vect(s);

function __m_scaling(s) = 
    let(v = __m_scaling_to_3_elems_scaling_vect(s))
    [
        [v[0], 0, 0, 0],
        [0, v[1], 0, 0],
        [0, 0, v[2], 0],
        [0, 0, 0, 1]
    ];
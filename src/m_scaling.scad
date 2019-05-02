function _to_vect(s) =
     len(s) == 3 ? s : (
         len(s) == 2 ? [s[0], s[1], 1] : (
             len(s) == 1 ? [s[0], 1, 1] : [s, s, s]
         ) 
     );

function m_scaling(s) = 
    let(v = _to_vect(s))
    [
        [v[0], 0, 0, 0],
        [0, v[1], 0, 0],
        [0, 0, v[2], 0],
        [0, 0, 0, 1]
    ];
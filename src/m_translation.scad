function _to_vect(v) =
     len(v) == 3 ? v : (
         len(v) == 2 ? [v[0], v[1], 0] : (
             len(v) == 1 ? [v[0], 0, 0] : [v, 0, 0]
         ) 
     );

function m_translation(v) = 
    let(vt = _to_vect(v))
    [
        [1, 0, 0, vt[0]],
        [0, 1, 0, vt[1]],
        [0, 0, 1, vt[2]],
        [0, 0, 0, 1]
    ];
function m_scaling(s) = 
    let(v = len(s) == 3 ? s : [s, s, s])
    [
        [v[0], 0, 0, 0],
        [0, v[1], 0, 0],
        [0, 0, v[2], 0],
        [0, 0, 0, 1]
    ];
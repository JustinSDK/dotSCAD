function m_shearing(sx = [0, 0], sy = [0, 0], sz = [0, 0]) = 
    let(
        sx_along_y = sx[0],
        sx_along_z = sx[1],
        sy_along_x = sy[0],
        sy_along_z = sy[1],
        sz_along_x = sz[0],
        sz_along_y = sz[1]  
    )
    [
        [1, sx_along_y, sx_along_z, 0],
        [sy_along_x, 1, sy_along_z, 0],
        [sz_along_x, sz_along_y, 1, 0],
        [0, 0, 0, 1]
    ];
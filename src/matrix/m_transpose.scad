function m_transpose(m) =
    let(
        column = len(m[0]),
        row = len(m)
    )
    [
        for(y = 0; y < column; y = y + 1)
        [
            for(x = 0; x < row; x = x + 1)
            m[x][y]
        ]
    ];
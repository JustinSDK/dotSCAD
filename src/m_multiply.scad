function m_multiply(ma, mb) = 
    let(
        c1 = [mb[0][0], mb[1][0], mb[2][0], mb[3][0]],
        c2 = [mb[0][1], mb[1][1], mb[2][1], mb[3][1]],
        c3 = [mb[0][2], mb[1][2], mb[2][2], mb[3][2]],
        c4 = [mb[0][3], mb[1][3], mb[2][3], mb[3][3]]
    )
    [
        [ma[0] * c1, ma[0] * c2, ma[0] * c3, ma[0] * c4],
        [ma[1] * c1, ma[1] * c2, ma[1] * c3, ma[1] * c4],
        [ma[2] * c1, ma[2] * c2, ma[2] * c3, ma[2] * c4],
        [ma[3] * c1, ma[3] * c2, ma[3] * c3, ma[3] * c4]
    ];
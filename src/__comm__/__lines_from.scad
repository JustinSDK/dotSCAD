function __lines_from(pts, closed = false) = 
    let(
        leng = len(pts),
        endi = leng - 1,
        lines = [for(i = 0; i < endi; i = i + 1) [pts[i], pts[i + 1]]]
    )
    closed ? [each lines, [pts[endi], pts[0]]] : lines;
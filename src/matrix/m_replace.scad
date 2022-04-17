function m_replace(m, x, y, value) =
    let(
		rowY = m[y],
        leng_rowY = len(rowY),
		newRowY = [
			each [for(i = 0; i < x; i = i + 1) rowY[i]],
			value,
			each [for(i = x + 1; i < leng_rowY; i = i + 1) rowY[i]]
		],
        row_leng = len(m)
	)
    [
        each [for(i = 0; i < y; i = i + 1) m[i]],
        newRowY,
        each [for(i = y + 1; i < row_leng; i = i + 1) m[i]]
    ];
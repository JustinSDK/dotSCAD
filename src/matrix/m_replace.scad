function m_replace(m, x, y, value) =
    let(
		rowY = m[y],
        leng_rowY = len(rowY),
		newRowY = [
            for(i = [0:leng_rowY - 1]) 
            if(i == x) value
            else rowY[i]
        ],
        row_leng = len(m)
	)
    [
        for(i = [0:row_leng - 1])
        if(i == y) newRowY
        else m[i]
    ];

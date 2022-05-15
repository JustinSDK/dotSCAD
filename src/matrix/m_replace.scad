function m_replace(m, x, y, value) =
    let(
		rowY = m[y],
		newRowY = [
            for(i = [0:len(rowY) - 1]) 
            if(i == x) value
            else rowY[i]
        ]
	)
    [
        for(i = [0:len(m) - 1])
        if(i == y) newRowY
        else m[i]
    ];

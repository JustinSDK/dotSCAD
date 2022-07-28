function m_replace(m, i, j, value) =
    let(
		rowI = m[i],
		newRowI = [
            for(c = [0:len(rowI) - 1]) 
            if(c == j) value
            else rowI[c]
        ]
	)
    [
        for(r = [0:len(m) - 1])
        if(r == i) newRowI
        else m[r]
    ];

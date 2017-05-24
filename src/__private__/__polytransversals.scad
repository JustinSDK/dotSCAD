function __polytransversals(transversals) =
    let(
        leng_trs = len(transversals),
        leng_tr = len(transversals[0]),
        lefts = [
            for(i = [1:leng_trs - 2]) 
                let(tr = transversals[leng_trs - i])
                    tr[0]
        ],
        rights = [
            for(i = [1:leng_trs - 2]) 
                let(tr = transversals[i])
                    tr[leng_tr - 1]
        ]
    ) concat(
        transversals[0], 
        rights, 
        __reverse(transversals[leng_trs - 1]), 
        lefts
    );
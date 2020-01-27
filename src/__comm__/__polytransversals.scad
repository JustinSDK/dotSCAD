use <util/reverse.scad>;

function __polytransversals(transversals) =
    let(
        leng_trs = len(transversals),
        leng_tr = len(transversals[0]),
        lefts = [
            for(i = 1; i < leng_trs - 1; i = i + 1)
                let(tr = transversals[leng_trs - i])
                    tr[0]
        ],
        rights = [
            for(i = 1; i < leng_trs - 1; i = i + 1)
                let(tr = transversals[i])
                    tr[leng_tr - 1]
        ]
    ) concat(
        transversals[0], 
        rights, 
        reverse(transversals[leng_trs - 1]), 
        lefts
    );
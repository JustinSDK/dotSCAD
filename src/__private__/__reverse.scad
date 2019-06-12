function __reverse(vt) = 
    let(to = len(vt) - 1)
    [
        for(i = [0:to])
            vt[to - i]
    ];
use <experimental/_impl/_pnoise1.scad>  ;

function pnoise1(from, to, step = 0.5) = 
    let(
        n = to - from + 1,
        slopes = rands(-1, 1, n)
    )
    [
        for(x = [0:step:n - 1]) 
        [from + x, _pnoise1(x, n, slopes)]
    ];
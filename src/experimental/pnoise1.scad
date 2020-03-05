use <experimental/_impl/_pnoise1.scad>  ;

function pnoise1(xs, gradients) = 
    let(
        from = floor(min(xs)),
        to = ceil(max(xs)),
        n = to - from + 1,
        grads = is_undef(gradients) ? rands(-1, 1, n) : gradients
    )
    [
        for(x = xs) 
        _pnoise1(x, n, grads)
    ];
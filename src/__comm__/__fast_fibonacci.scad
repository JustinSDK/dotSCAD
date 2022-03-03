function __fast_fibonacci_sub(nth) = 
    let(
        _f = __fast_fibonacci_2_elems(floor(nth / 2)),
        a = _f[0],
        b = _f[1],
        c = a * (b * 2 - a),
        d = a ^ 2 + b ^ 2
    ) 
    nth % 2 == 0 ? [c, d] : [d, c + d];

function __fast_fibonacci_2_elems(nth) =
    nth == 0 ? [0, 1] : __fast_fibonacci_sub(nth);
    
function __fast_fibonacci(nth) =
    __fast_fibonacci_2_elems(nth)[0];
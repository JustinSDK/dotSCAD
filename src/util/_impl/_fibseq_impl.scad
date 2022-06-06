use <../../__comm__/__fast_fibonacci.scad>

function _fibonacci_sequence(seq, n, i = 2) =
    i > n ? seq :
    _fibonacci_sequence(
        [each seq, seq[i - 1] + seq[i - 2]],
        n,
        i + 1
    );    

function _fibseq_impl(from, to) =
    let(f = __fast_fibonacci(from))
    from == to ? [f] : 
    _fibonacci_sequence(
        [f, __fast_fibonacci(from - 1) + f], 
        to - from
    );
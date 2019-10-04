/**
* fibseq.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-fibseq.html
*
**/ 

include <__comm__/__fast_fibonacci.scad>;

function _fibonacci_sequence(seq, n, i = 2) =
    i > n ? seq :
    _fibonacci_sequence(
        concat(seq, [seq[i - 1] + seq[i - 2]]),
        n,
        i + 1
    );   

function fibseq(from, to) =
    let(f = __fast_fibonacci(from))
    from == to ? [f] : 
    _fibonacci_sequence(
        [f, __fast_fibonacci(from - 1) + f], 
        to - from
    );
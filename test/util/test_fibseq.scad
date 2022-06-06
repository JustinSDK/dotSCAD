use <util/fibseq.scad>

module test_fibseq() {
    echo("==== test fibseq ====");

    assert([1, 1, 2, 3, 5, 8, 13, 21, 34, 55] == fibseq(1, 10)); 
}

test_fibseq();
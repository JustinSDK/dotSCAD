use <lines_intersection.scad>

module test_lines_intersection() {
    echo("==== test_lines_intersection ====");
        
    line1 = [[0, 0], [0, 10]];
    line2 = [[5, 0], [-5, 5]];
    line3 = [[5, 0], [2.5, 5]];

    assert(lines_intersection(line1, line2) == [0, 2.5]);
    assert(lines_intersection(line1, line3, ext = true) == [0, 10]);

    line4 = [[0, 0, 0], [10, 10, 10]];
    line5 = [[10, 0, 0], [0, 10, 10]];
    assert(lines_intersection(line4, line5) == [5, 5, 5]);
}

test_lines_intersection();
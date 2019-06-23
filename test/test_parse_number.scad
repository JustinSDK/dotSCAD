module test_parse_number() {
    echo("==== test_parse_number ====");

    include <unittest.scad>;
    include <util/sub_str.scad>;
    include <split_str.scad>;
    include <parse_number.scad>;

    assertEqualNum(11, parse_number("10") + 1);   
    assertEqualNum(-0.1, parse_number("-1.1") + 1);  
}

test_parse_number();

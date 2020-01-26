use <unittest.scad>;
use <util/parse_number.scad>;

module test_parse_number() {
    echo("==== test_parse_number ====");

    assertEqualNum(11, parse_number("10") + 1);   
    assertEqualNum(-0.1, parse_number("-1.1") + 1);  
}

test_parse_number();

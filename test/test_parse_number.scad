echo("==== test_parse_number ====");

include <unittest.scad>;
include <sub_str.scad>;
include <split_str.scad>;
include <parse_number.scad>;

assertEqual(11, parse_number("10") + 1);   
assertEqual(-0.1, parse_number("-1.1") + 1);  

use <util/parse_number.scad>

module test_parse_number() {
    echo("==== test_parse_number ====");

    assert(11 == parse_number("10") + 1);   
    assert(-1.1 == parse_number("-1.1"));  
    assert(12345 == parse_number("12345"));  
}

test_parse_number();

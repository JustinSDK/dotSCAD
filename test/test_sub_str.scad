module test_sub_str() {
    echo("==== test_sub_str ====");

    include <unittest.scad>;
    include <sub_str.scad>;

    assert("hello" == sub_str("helloworld", 0, 5)); 
    assert("world" == sub_str("helloworld", 5));    
}

test_sub_str();
use <util/sub_str.scad>

module test_sub_str() {
    echo("==== test_sub_str ====");

    assert("hello" == sub_str("helloworld", 0, 5)); 
    assert("world" == sub_str("helloworld", 5));    
}

test_sub_str();
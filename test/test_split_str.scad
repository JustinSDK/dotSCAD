module test_split_str() {
    echo("==== test_split_str ====");

    include <unittest.scad>;
    include <sub_str.scad>;
    include <split_str.scad>;

    assertEqual(["hello", "world"], split_str("hello,world", ","));  
}

test_split_str();
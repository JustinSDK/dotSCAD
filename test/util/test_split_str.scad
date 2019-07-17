module test_split_str() {
    echo("==== test_split_str ====");

    include <unittest.scad>;
    include <util/sub_str.scad>;
    include <util/split_str.scad>;

    assert(["hello", "world","abc", "xyz"] == split_str("hello,world,abc,xyz", ","));  
}

test_split_str();
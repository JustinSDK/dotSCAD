use <util/split_str.scad>

module test_split_str() {
    echo("==== test_split_str ====");

    assert(["hello", "world","abc", "xyz"] == split_str("hello,world,abc,xyz", ","));  
}

test_split_str();
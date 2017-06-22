include <unittest.scad>;
include <sub_str.scad>;
include <split_str.scad>;

assertEqual(["hello", "world"], split_str("hello,world", ","));  
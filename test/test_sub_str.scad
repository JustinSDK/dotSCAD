
include <unittest.scad>;
include <sub_str.scad>;

assertEqual("hello", sub_str("helloworld", 0, 5)); 
assertEqual("world", sub_str("helloworld", 5));    
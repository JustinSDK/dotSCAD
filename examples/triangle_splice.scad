use <polyline2d.scad>

tri_side_leng = 20;
tris_per_line = 10;
lines = 3;
line_width = 1;

points = [[10, -6], [-6.5, -6], [-3, 0], [0, 0]];
// points = [[0, 0], [1.5, 2.5], [1.5, -6], [-4, -6], [-6.5, 0]];
triangle_splice(tri_side_leng, tris_per_line, lines, line_width) 
    triangle_pattern(points, line_width);


module triangle_pattern(points, line_width) {
    polyline2d(points, line_width);
    rotate([0, 0, 120]) polyline2d(points, line_width);
    rotate([0, 0, 240]) polyline2d(points, line_width);
}

module triangle_splice_one_line(tri_leng, tris, line_width) {
    half_leng = tri_leng / 2;
    height = half_leng * sqrt(3);
    hd3 = height / 3;
    
    for(i = [0 : tris - 1]) {
        x_offset = half_leng * i;
        is_even = i % 2 == 0;
        translate([x_offset, is_even ? 0 : hd3, 0]) 
        mirror([0, is_even ? 0 : 1, 0])
            children();    
    }

}

module triangle_splice(length, tris_per_line, lines, line_width = 1) {
    half_leng = length / 2;
    height = half_leng * sqrt(3);
    hd3 = height / 3;
    
    for(i = [0 : lines - 1]) {
        is_even = i % 2 == 0;
        hoffset = height * i;
        translate([0, is_even ? hoffset : hoffset + hd3]) 
        mirror([0, is_even ? 0 : 1, 0])
        triangle_splice_one_line(length, tris_per_line, line_width) 
            children();
    }
} 
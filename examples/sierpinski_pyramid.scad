include <hull_polyline3d.scad>;

side_leng = 100;
min_leng = 5;
thickness = 2.5;

sierpinski_pyramid(side_leng, min_leng, thickness, $fn = 4);

module sierpinski_pyramid(side_leng, min_leng, thickness) {
    pyramid_frame(side_leng, thickness);    
    if(side_leng > min_leng){
        half_len = side_leng / 2;
        h = half_len * 0.707107;
        pt = [side_leng / 4, side_leng / 4, 0];
        for(i=[0:3]) {
            rotate([0, 0, i * 90])
            translate(pt)
                sierpinski_pyramid(half_len, min_leng, thickness);
        }
        translate([0, 0, h]) 
            sierpinski_pyramid(half_len, min_leng, thickness);
    }
}

module pyramid_frame(side_leng, thickness) {
    half_len = side_leng / 2;
    h = half_len * 1.414214;
    
    tri_pts = [[0, 0, h], [half_len, half_len, 0], [half_len, -half_len, 0], [0, 0, h]];
    line_pts = [[half_len, half_len, 0], [-half_len, half_len, 0]];
    
    hull_polyline3d(tri_pts, thickness);
    mirror([1, 0, 0]) 
        hull_polyline3d(tri_pts, thickness);
    
    hull_polyline3d(line_pts, thickness);
    mirror([0, 1, 0]) 
        hull_polyline3d(line_pts, thickness);
}
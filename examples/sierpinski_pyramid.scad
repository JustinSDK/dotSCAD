include <hull_polyline3d.scad>;

width = 100;
min_width = 5;
thickness = 2.5;
$fn = 4;

sierpinski_pyramid(width, min_width, thickness);

module sierpinski_pyramid(width, min_width, thickness) {
    pyramid_frame(width, thickness);    
    if(width > min_width){
        half_w = width / 2;
        h = half_w * 0.707107;
        pt = [width / 4, width / 4, 0];
        for(i=[0:3]) {
            rotate([0, 0, i * 90])
            translate(pt)
                sierpinski_pyramid(half_w, min_width, thickness);
        }
        translate([0, 0, h]) 
            sierpinski_pyramid(half_w, min_width, thickness);
    }
}

module pyramid_frame(width, thickness) {
    half_w = width / 2;
    h = half_w * 1.414214;
    
    tri_pts = [[0, 0, h], [half_w, half_w, 0], [half_w, -half_w, 0], [0, 0, h]];
    line_pts = [[half_w, half_w, 0], [-half_w, half_w, 0]];
    
    hull_polyline3d(tri_pts, thickness = thickness);
    mirror([1, 0, 0]) 
        hull_polyline3d(tri_pts, thickness = thickness);
    
    hull_polyline3d(line_pts, thickness = thickness);
    mirror([0, 1, 0]) 
        hull_polyline3d(line_pts, thickness = thickness);
}
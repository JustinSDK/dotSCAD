use <polyline_join.scad>

side_leng = 100;
min_leng = 5;
diameter = 2.5;

sierpinski_pyramid(side_leng, min_leng, diameter, $fn = 4);

module sierpinski_pyramid(side_leng, min_leng, diameter) {
    pyramid_frame(side_leng, diameter);    
    if(side_leng > min_leng){
        half_leng = side_leng / 2;
        h = half_leng * 0.707107;
        pt = [side_leng / 4, side_leng / 4, 0];
        for(i=[0:3]) {
            rotate([0, 0, i * 90])
            translate(pt)
                sierpinski_pyramid(half_leng, min_leng, diameter);
        }
        translate([0, 0, h]) 
            sierpinski_pyramid(half_leng, min_leng, diameter);
    }
}

module pyramid_frame(side_leng, diameter) {
    half_leng = side_leng / 2;
    h = half_leng * 1.414214;
    
    tri_pts = [[0, 0, h], [half_leng, half_leng, 0], [half_leng, -half_leng, 0], [0, 0, h]];
    line_pts = [[half_leng, half_leng, 0], [-half_leng, half_leng, 0]];
    
    polyline_join(tri_pts) 
	    sphere(d = diameter);
    mirror([1, 0, 0]) 
	polyline_join(tri_pts) 
	    sphere(d = diameter);
    
	polyline_join(line_pts) 
	    sphere(d = diameter);
    mirror([0, 1, 0]) 
	polyline_join(line_pts) 
	    sphere(d = diameter);
}
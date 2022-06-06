use <polyline_join.scad>

level = 1;
leng = 50;
diameter = 5;
segs_per_side = 10;
center = false;

module string_tetrahedron(leng, diameter, segs_per_side, line_fn) {
    module lines_between(side1, side2, diameter, segs) {
        function pts(p1, p2, segs) =
            let(p = p2 - p1) [for(i = [0:segs]) p1 + p / segs * i];

        pts1 = pts(side1[0], side1[1], segs);
        pts2 = pts(side2[0], side2[1], segs);
        
        leng = len(pts1);
		r = diameter / 2;
        polyline_join(points = [pts1[0], pts2[0]])
		    sphere(r);
        for(i = [1:leng - 2]) {
            polyline_join([pts1[i], pts2[i]])
			    sphere(r);
        }
        end = leng - 1;
		polyline_join([pts1[end], pts2[end]])
		    sphere(r);
    }

    function height(leng) = 
        leng * sqrt(1 - 4 / 9 * pow(sin(60), 2));

    function vts(leng) = 
        let(
            half_leng = leng / 2,
            center_y = half_leng * tan(30),
            vt1 = [half_leng, - center_y, 0],
            vt2 = [0, leng * sin(60) - center_y, 0],
            vt3 = [-half_leng, -center_y, 0],
            vt4 = [0, 0, height(leng)]
        ) [vt1, vt2, vt3, vt4];
        
    $fn = line_fn;
    
    half_leng = leng / 2;
    
    vts = vts(leng);

    vt1 = vts[0];
    vt2 = vts[1];
    vt3 = vts[2];
    vt4 = vts[3];

    lines_between([vt1, vt2], [vt3, vt4], diameter, segs_per_side);
    lines_between([vt2, vt3], [vt1, vt4], diameter, segs_per_side);
    lines_between([vt3, vt1], [vt2, vt4], diameter, segs_per_side);
}

module string_tetrahedrons(level, leng, diameter, segs_per_side, center) {

    function height(leng) = 
        leng * sqrt(1 - 4 / 9 * pow(sin(60), 2));
        
    if(level == 0) {
        string_tetrahedron(leng * 2, diameter, segs_per_side, 6);
    }
    else {
    
        half_leng = leng / 2;
        center_y = half_leng * tan(30);

        translate([0, center_y * 2])
            string_tetrahedrons(level - 1, half_leng, diameter, segs_per_side, center);

        translate([half_leng, -center_y])
            string_tetrahedrons(level - 1, half_leng, diameter, segs_per_side, center);

        translate([-half_leng, -center_y])
            string_tetrahedrons(level - 1, half_leng, diameter, segs_per_side, center);

        translate([0, 0, height(leng)])
            string_tetrahedrons(level - 1, half_leng, diameter, segs_per_side, center);


        if(center) {
            rotate(60)
                  string_tetrahedrons(level - 1, half_leng, diameter, segs_per_side, center);

            a = atan(height(leng * 2) / (2 * center_y));

            for(i = [0:120:240]) {
                rotate(i)
                translate([0, -center_y * 2])
                rotate([a, 0, 0])
                translate([0, center_y * 2])
                rotate([180, 0, 0])
                scale(0.9427)
                    string_tetrahedrons(level - 1, half_leng, diameter, segs_per_side, center);
            }  
        }        
    }
}

string_tetrahedrons(level, leng, diameter, segs_per_side, center);



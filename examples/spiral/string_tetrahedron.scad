use <polyline_join.scad>

leng = 50;
diameter = 5;
segs_per_side = 20;
line_fn = 5;
model = "Tetrahedron"; // [Tetrahedron, Base, Both]


module string_tetrahedron(leng, diameter, segs_per_side, line_fn) {
    module lines_between(side1, side2, diameter, segs) {
        function pts(p1, p2, segs) =
            let(p = p2 - p1)
            [for(i = [0:segs]) p1 + p / segs * i];

        pts1 = pts(side1[0], side1[1], segs);
        pts2 = pts(side2[0], side2[1], segs);
        
		r = diameter / 2;
        for(i = [0:len(pts1) - 1]) {
		    polyline_join([pts1[i], pts2[i]])
			    sphere(r);
        }
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

module base(leng, diameter, line_fn) {
    vts = vts(leng);
    r = leng / 4;
    half_th = diameter / 2;

    difference() {
        sphere(r, $fn = 48);
        
        translate([0, 0, -r])
        linear_extrude(r) 
            square(r * 2, center = true);
        
        translate([0, 0, height(leng) + half_th])
        rotate([0, 180, 0]) 
        translate([0, -leng / 2 * tan(30), 0]) 
        hull() {
            translate(vts[0])
                sphere(half_th, $fn = line_fn);
            translate(vts[1])
                sphere(half_th, $fn = line_fn);
            translate(vts[2])
                sphere(half_th, $fn = line_fn);
            translate(vts[3])
                sphere(half_th, $fn = line_fn);     
        }
    }
}

if(model == "Tetrahedron") {
    string_tetrahedron(leng, diameter, segs_per_side, line_fn);
} else if(model == "Base") {
    base(leng, diameter, line_fn);
} else {
    translate([0, 0, height(leng) + half_th])
    rotate([0, 180, 0]) 
    translate([0, -leng / 2 * tan(30), 0]) 
        string_tetrahedron(leng, diameter, segs_per_side, line_fn);
        
    base(leng, diameter, line_fn);
}


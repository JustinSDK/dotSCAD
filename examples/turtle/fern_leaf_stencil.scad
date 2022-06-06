use <polyline_join.scad>
use <hollow_out.scad>
use <turtle/t2d.scad>

radius = 40;
height = 3;
thickness = 1;
width = 1;

min_leng = 0.1;
k1 = 0.9;
k2 = 0.3;

module fern_leaf(t, leng, min_leng, k1, k2, width) {
    t1 = t2d(t, "forward", leng = leng);
    polyline_join([t2d(t, "point"), t2d(t1, "point")])
	    circle(width / 2);
    
    if(leng > min_leng) {
        fern_leaf(
            t2d(t1, "turn", angle = 70), 
            k2 * leng, min_leng, k1, k2, width
        );
        
        t2 = t2d(t1, "forward", leng = k1 * leng);
        polyline_join([t2d(t1, "point"), t2d(t2, "point")])
		    circle(width / 2);
        
        t3 = t2d(t2, "turn", angle = -69.0);
        fern_leaf(
            t3, 
            k1 * k2 * leng, min_leng, k1, k2, width
        );
        fern_leaf(
            t2d(t3, "turn", angle = 68.0), 
            k1 * k1 * leng, min_leng, k1, k2, width
        );
    }
}

module fern_leaf_stencil(radius, height, thickness, width, min_leng, k1, k2) {
    $fn = 48;

    linear_extrude(thickness) 
    difference() {
        union() {
            translate([radius, 0])
            scale([1, 0.5, 1])
            hollow_out(radius / 3) 
                circle(radius / 1.5);
                
            circle(radius);
        }
        translate([-radius, 0]) 
            fern_leaf(
                t2d(point = [0, 0], angle = 0), 
                radius / 5, min_leng, k1, k2, width
            );
    }

    linear_extrude(height) 
    hollow_out(thickness) 
        circle(radius + thickness);
}

fern_leaf_stencil(radius, height, thickness, width, min_leng, k1, k2);

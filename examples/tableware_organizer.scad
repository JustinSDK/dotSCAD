use <polyline2d.scad>
use <util/fibseq.scad>

smallest_length = 30;
height1 = 60;
height2 = 120;
thickness = 1;

module tableware_organizer(smallest_length, height1, height2, thickness) {
    module golden_rectangle(fseq, i = 0) {
        if(i < len(fseq) - 1) {
            f1 = fseq[i] * smallest_length;
            f2 = fseq[i + 1] * smallest_length;
            
            linear_extrude(f1 < 3 * smallest_length ? height1 : height2) 
                polyline2d([[0, 0], [f1, 0], [f1, f1], [0, f1], [0, 0]], thickness);
                        
            
            linear_extrude(thickness) 
                square([f1, f1]);
            
            translate([0, f1 - f2, 0]) 
            rotate(90)
                golden_rectangle(fseq, i + 1);    
        }
    }

    p1 = smallest_length * 3 / 4;
    p2 = smallest_length / 4;    
    double_thickness = thickness * 2;
    ex_h = smallest_length * 8;
    angles = [90, 90, 0];

    module slash(pts) {
        rotate(angles) 
        linear_extrude(ex_h, center = true) 
            polyline2d(pts, double_thickness);        
    }
    
    module slash_diffs1() {
        x = smallest_length * 2.5;
        pts = [[-p1, -p1], [p1, p1]];
        for(h = [height2 / 2, height2 / 3, height2 / 1.5]) {
            translate([x, 0, h]) slash(pts);      
        }   
    }

    module slash_diffs2() {
        x = smallest_length * 0.5;
        pts = [[-p2, -p2], [p2, p2]];

        for(h = [height1 / 3, height1 / 1.5]) {
            translate([x, 0, h]) slash(pts);
            translate([-x, 0, h]) slash(pts);            
        }   
    }    
    
    difference() {
        golden_rectangle(fibseq(1, 5));
        slash_diffs1();
        slash_diffs2();
    }
}

tableware_organizer(smallest_length, height1, height2, thickness);
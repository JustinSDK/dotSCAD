use <voxel/vx_circle.scad>
use <voxel/vx_polygon.scad>

w = 5;
merged_dino = false;
eye_spacing = 0.4;
base_x_blocks = 10;
base_y_blocks = 6;

part = "DEMO"; // [DINO, EYE, CACTUS, BASE, DEMO]

module chrome_dino(w, merged = false) {
    module body(w) {
        difference() {
            polygon([
                [0, 0],
                [0, w],
                [-3 * w, w],
                [-3 * w, 2 * w],
                [-4 * w, 2 * w],
                [-4 * w, 3 * w],
                [-5 * w, 3 * w],
                [-5 * w, 9 * w],
                [-4 * w, 9 * w],
                [-4 * w, 7 * w],
                [-3 * w, 7 * w],
                [-3 * w, 6 * w],
                [-2 * w, 6 * w],
                [-2 * w, 5 * w],
                [0, 5 * w],
                [0, 6 * w],
                [w, 6 * w],
                [w, 7 * w],
                [3 * w, 7 * w],
                [3 * w, 8 * w],
                [4 * w, 8 * w],
                [4 * w, 9 * w],
                [5 * w, 9 * w],
                [5 * w, 15 * w],
                [6 * w, 15 * w],
                [6 * w, 16 * w],
                [14 * w, 16 * w],
                [14 * w, 15 * w],
                [15 * w, 15 * w],
                [15 * w, 11 * w],
                [11 * w, 11 * w],
                [11 * w, 10 * w],
                [13 * w, 10 * w],
                [13 * w, 9 * w],
                [10 * w, 9 * w],
                [10 * w, 3 * w],
                [9 * w, 3 * w],
                [9 * w, 2 * w],
                [8 * w, 2 * w],
                [8 * w, w],
                [7 * w, w],
                [7 * w, 0],
            ]); 
        
          translate([7 * w, 14 * w]) square(w, center = true);
        }
    }

    module hand(w) {
        polygon([
            [10 * w, 7 * w],
            [12 * w, 7 * w],
            [12 * w, 5 * w],
            [11 * w, 5 * w],
            [11 * w, 6 * w],
            [10 * w, 6 * w]
        ]);
    }

    module leg_l(w) {
        polygon([
            [5 * w, 0],
            [5 * w, -w],
            [6 * w, -w],
            [6 * w, -4 * w],
            [8 * w, -4 * w],
            [8 * w, -3 * w],
            [7 * w, -3 * w],
            [7 * w, 0],
        ]);
    }

    module leg_r(w) {
        polygon([
            [w, 0],
            [w, -4 * w],
            [3 * w, -4 * w],
            [3 * w, -3 * w],
            [2 * w, -3 * w],
            [2 * w, -2 * w],
            [3 * w, -2 * w],
            [3 * w, -w],
            [4 * w, -w],
            [4 * w, 0]
        ]);
    }

    module dino_left(w) {      
        linear_extrude(w * 2.5) body(w);
        linear_extrude(w * 2) {
            hand(w);
            leg_l(w);
        }
    }

    module dino_right(w) {
        linear_extrude(w * 2.5) mirror([1, 0, 0]) body(w);
        linear_extrude(w * 2) mirror([1, 0, 0]) {
            hand(w);
            leg_r(w);
        }
    }
    
    if(merged) {
        dino_left(w);
        translate([0, 0, w * 5]) rotate([0, 180, 0]) dino_right(w);
    } else {
        translate([w * 6, 0, 0]) dino_left(w);
        translate([w * -6, 0, 0]) dino_right(w);
    }
}

module blocks(points) {
    for(pt = points) {
        translate(pt) square(1);
    };
}

module cactus(w) {
    linear_extrude(w * 3) {
        translate([2 * w, w * 7]) 
        scale(w) 
            blocks(
                vx_polygon([
                    [0, 2],
                    [3, 2],
                    [5, 4],
                    [5, 10],
                    [5, 10],
                    [3, 10],
                    [3, 6],
                    [0, 4],
                    
                ], filled = true)
            );

        translate([-2 * w, w * 5]) 
        scale(w)
            blocks(
                vx_polygon([
                    [-1, 0],
                    [-3, 0],
                    [-6, 2],
                    [-6, 6],
                    [-6, 6],
                    [-4, 6],
                    [-4, 4],
                    [-1, 2],
                    
                ], filled = true)
            );       
        
        scale(w) 
            blocks(
                vx_polygon([
                    [-2, 0],
                    [2, 0],
                    [2, 20],
                    [1, 22],
                    [0, 22],
                    [-1, 22],
                    [-2, 20]
                ], filled = true)        
            ); 
    }
}

module base(w, base_x_blocks, base_y_blocks) {
   linear_extrude(w) {
        translate([0, -w]) 
            square([base_x_blocks * w, base_y_blocks * w + 2 * w]);

        translate([0, base_y_blocks * w / 2]) 
        scale(w) 
        blocks(vx_circle(base_y_blocks / 2, filled = true));

        translate([base_x_blocks * w, base_y_blocks * w / 2]) 
        scale(w) 
            blocks(vx_circle(base_y_blocks / 2, filled = true));
   }   
}

module eye(w, eye_spacing) {
    translate([0, 0, -eye_spacing]) 
    rotate([0, -90, 0]) 
    linear_extrude(w * 5) 
        offset(delta = -eye_spacing) square(w);
}

if(part == "DINO") {
    chrome_dino(w, merged_dino);
}
else if(part == "EYE") {
    eye(w, eye_spacing);
}
else if(part == "CACTUS") {
    cactus(w);
}
else if(part == "BASE") { 
   base(w, base_x_blocks, base_y_blocks);
}
else if(part == "DEMO") {
    wd = 5;
    translate([0, wd * 5.5, wd * 5]) 
    rotate([90, 0, 0]) {
        color("DimGray") chrome_dino(wd, true);
        color("white") 
        linear_extrude(wd * 5)
            translate([7 * wd, 14 * wd]) square(wd, center = true);
    }
    color("white") base(wd, 10, 6);
    
    translate([wd * 25, wd * 10, 0]) {
        translate([wd * 4.25, wd * 4.25, 0]) 
        color("SlateGray") 
        rotate([90, 0, 0])  
            cactus(wd);

        color("white") base(wd, 10, 6);
    }
    
    translate([-wd * 35, wd * 10, 0]) {
        color("SlateGray") {
            translate([wd * 4.25, wd * 4, 0]) 
            rotate([90, 0, 0])  
            mirror([1, 0, 0]) 
                cactus(wd);
                
            scale(0.75)
            translate([wd * 30, wd * 5, 0]) 
            rotate([90, 0, 0])  
                cactus(wd);       
        }
         color("white") base(wd, 30, 6);                
    }
    
}

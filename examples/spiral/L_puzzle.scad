use <util/fibseq.scad>

model = "ALL"; // [ALL, PIECE1, PIECE2]

level = 10;
thickness = 1;
thickness_step = true;
p = 1.272;
spacing = 0;

// The idea is from: https://www.facebook.com/permalink.php?story_fbid=381947752968951&id=100034611874448

// n: 1 or 2
module L_piece(n, thickness, p = 1.272, spacing = 0) {
    sides = [for(i = [0:5]) pow(p, n + i) - spacing];

    linear_extrude(thickness)
    polygon([
        [0, 0],
        [sides[5], 0],
        [sides[5], sides[2]],
        [sides[3], sides[2]],
        [sides[3], sides[4]],
        [0, sides[4]],
    ]);
}
    
module L_puzzle(level, thickness, thickness_step = true, p = 1.272) {
    s4 = pow(p, 4);
    s5 = pow(p, 5);
    s6 = pow(p, 6);
    s7 = pow(p, 7);

    module p1() {
        color(rands(0, 1, 3))
        L_piece(2, thickness);
    }

    module p2() {
        offset1 = s7;
        offset2 = s4 + s6;
        
        translate([0, offset1])
        rotate(-90) {
            p1();
            
            translate([offset1, offset2])
            mirror([1, 0, 0])
            rotate(-90)
            color(rands(0, 1, 3))
                L_piece(1, thickness_step ? thickness * 2 : thickness);
        }
    }

    fibs = fibseq(1, round(level / 2) + 1);
    
    module _L_puzzle(level) {
        if(level == 1) {
            p1();
        }
        else if(level == 2) {
            p2();
        }
        else {
            nth = round(level / 2 - 1);
            
            is_even = level % 2 == 0;
            
            offset1 = is_even ?
                          s5 * fibs[nth - 1] + s7 * fibs[nth] :
                          s4 * fibs[nth - 1] + s6 * fibs[nth];
                          
            offset2 = is_even ?
                          s4 * fibs[nth] + s6 * fibs[nth + 1] :
                          s5 * fibs[nth - 1] + s7 * fibs[nth];
            
            translate([0, offset1])
            rotate(-90) {
                scale([1, 1, thickness_step ? 1 + level * 0.05 : 1])
                    _L_puzzle(level - 1);
 
                translate([offset1, offset2]) 
                mirror([1, 0, 0])
                rotate(-90)
                scale([1, 1, thickness_step ? 1 + (level - 1) * 0.05 : 1])
                    _L_puzzle(level - 2);
            }
        }
    }
    
    _L_puzzle(level);
}

if(model == "ALL") {
    L_puzzle(level, thickness, thickness_step, p);
}
else if(model == "PIECE1") {
    L_piece(1, thickness, p, spacing);
}
else if(model == "PIECE2") {
    L_piece(2, thickness, p, spacing);
}
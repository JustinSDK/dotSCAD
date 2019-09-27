include <line2d.scad>;
include <turtle/turtle2d.scad>;

style = "MIRROR"; // [TREES, INVERTED, MIRROR]
trunk_angle = 86; // [1:90]
max_trunk_length = 400;
min_trunk_length = 2;
width = 1.5;
k1 = 1.5;
k2 = 1.0;

// Style: TREES, INVERTED, MIRROR
module forest(trunk_angle, max_trunk_length, min_trunk_length, style = "TREES", k1 = 1.5, k2 = 1.0, width = 1) {
	k = 1.0 / (k1 + 2 *  k2 + 2 * (k1 +  k2) * cos(trunk_angle));
	
    function forward(t, leng) = turtle2d("forward", t, leng);
    function turn(t, ang) = turtle2d("turn", t, ang);
    function pt(t) = turtle2d("pt", t);
    
	module trunk(t, length) {
        if (length > min_trunk_length) {
		    // baseline
			if(style != "INVERTED") {
			    line2d(t[0], pt(forward(t, length)), width);
			} else {
			    inverted_trunk(t, length);
			}
			
			if(style == "MIRROR") {
				 mirror([0, 1, 0]) inverted_trunk(t, length);
			} 
			
			trunk(t, k * k1 * length);
			
			// left side of "k * k1 * length" trunks
			t1 = turn(
			    forward(t, k * k1 * length),
				trunk_angle
			);			
			trunk(t1, k * k1 * length);
			
			// right side of "k * k1 * length" trunks
			t2 = turn(
			    forward(t1, k * k1 * length), 
				-2 * trunk_angle
			);
			trunk(t2, k * k1 * length);
			
			// "k * length" trunks
			t3 = turn(
			    forward(t2, k * k1 * length), 
				trunk_angle
			);
			trunk(t3, k * length);
			
			// left side of "k *  k2 * length" trunks
			t4 = turn(
			    forward(t3, k * length), trunk_angle
			);
			trunk(t4, k *  k2 * length);
			
			// right side of "k *  k2 * length" trunks
			t5 = turn(
			    forward(t4, k *  k2 * length), -2 * trunk_angle
		    );
			trunk(t5, k *  k2 * length);
		
		    // "k *  k2 * length" trunks
			trunk(
			    turn(
				    forward(t5, k *  k2 * length), 
					trunk_angle
				), 
				k *  k2 * length
			);
        }
	}
	 
	module inverted_trunk(t, length) {
	    
		if(k * k1 * length > min_trunk_length) {
			t1 = forward(t, k * k1 * length);
			t2 = forward(turn(t1, trunk_angle), k * k1 * length);
			t3 = forward(turn(t2, -2 * trunk_angle), k * k1 * length);
			offset(r = width * 0.25) polygon([t1[0], t2[0], t3[0]]);
			
			if(k * length > min_trunk_length && k * k2 * length > min_trunk_length) {
				t4 = forward(turn(t3, trunk_angle), k * length);				
				t5 = forward(turn(t4, trunk_angle), k * k2 * length);
				t6 = forward(turn(t5, -2 * trunk_angle), k * k2 * length);
				offset(r = width * 0.25) polygon([t4[0], t5[0], t6[0]]);
		        
			}
		}
	}
	
    trunk(turtle2d("create", 0, 0, 0), max_trunk_length);
	
	if(style == "INVERTED") {
	    line2d([0, 0], [max_trunk_length, 0], width);
	}
}


forest(trunk_angle, max_trunk_length, min_trunk_length, style, k1, k2, width);

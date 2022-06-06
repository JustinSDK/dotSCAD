use <line2d.scad>
use <turtle/t2d.scad>

style = "MIRROR"; // [TREES, INVERTED, MIRROR]
trunk_angle = 86; // [1:90]
max_trunk_length = 400;
min_trunk_length = 2;
width = 1.5;
k1 = 1.5;
k2 = 1.0;

forest(trunk_angle, max_trunk_length, min_trunk_length, style, k1, k2, width);

// Style: TREES, INVERTED, MIRROR
module forest(trunk_angle, max_trunk_length, min_trunk_length, style = "TREES", k1 = 1.5, k2 = 1.0, width = 1) {
	k = 1.0 / (k1 + 2 *  k2 + 2 * (k1 +  k2) * cos(trunk_angle));
    
	function forward_turn(t, leng, angle) = t2d(t, [
		["forward", leng],
		["turn", angle]
    ]);

	function turn_forward(t, angle, leng) = t2d(t, [
		["turn", angle],
		["forward", leng]
    ]);

	module trunk(t, length) {
        if (length > min_trunk_length) {
		    // baseline
			if(style != "INVERTED") {
			    line2d(
					t[0], 
					t2d(t, [
						["forward", length],
						["point"]
					]), 
					width
				);
			} else {
			    inverted_trunk(t, length);
			}
			
			if(style == "MIRROR") {
				 mirror([0, 1, 0]) 
				     inverted_trunk(t, length);
			} 

			leng = k * k1 * length;
			
			trunk(t, leng);
			
			// left side of "k * k1 * length" trunks
			t1 = forward_turn(t, leng, trunk_angle);
			trunk(t1, leng);
			
			// right side of "k * k1 * length" trunks
			t2 = forward_turn(t1, leng, -2 * trunk_angle);
			trunk(t2, leng);
			
			// "k * length" trunks
			t3 = forward_turn(t2, leng, trunk_angle);
			trunk(t3, k * length);

			leng2 = k *  k2 * length;
			
			// left side of "k *  k2 * length" trunks
			t4 = forward_turn(t3, k * length, trunk_angle);
			trunk(t4, leng2);
			
			// right side of "k *  k2 * length" trunks
			t5 = forward_turn(t4, leng2, -2 * trunk_angle);
			trunk(t5, k *  k2 * length);
		
		    // "k *  k2 * length" trunks
			trunk(
				forward_turn(t5, leng2, trunk_angle), 
				leng2
			);
        }
	}
	 
	module inverted_trunk(t, length) {
		leng = k * k1 * length;
		if(leng > min_trunk_length) {
			t1 = t2d(t, "forward", leng = leng);
			t2 = turn_forward(t1, trunk_angle, leng);
			t3 = turn_forward(t2, -2 * trunk_angle, leng);

			offset(r = width * 0.25) 
			    polygon([t1[0], t2[0], t3[0]]);
			
			leng2 = k * k2 * length;
			if(k * length > min_trunk_length && leng2 > min_trunk_length) {
				t4 = turn_forward(t3, trunk_angle, k * length);
				t5 = turn_forward(t4, trunk_angle, leng2);
				t6 = turn_forward(t5, -2 * trunk_angle, leng2);

				offset(r = width * 0.25) 
				    polygon([t4[0], t5[0], t6[0]]);
			}
		}
	}
	
    trunk(
		t2d(point = [0, 0], angle = 0), 
		max_trunk_length
	);
	
	if(style == "INVERTED") {
	    line2d([0, 0], [max_trunk_length, 0], width);
	}
}

